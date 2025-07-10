CREATE TYPE role_enum AS ENUM ('customer', 'store', 'admin');

CREATE TABLE "users" (
  "id" uuid PRIMARY KEY,
  "email" text NOT NULL,
  "password" text NOT NULL,
  "firstName" text NOT NULL,
  "lastName" text,
  "userName" text,
  "displayName" text NOT NULL,
  "deleted" bool DEFAULT false,
  "phoneNumber" text,
  "profilePicture" text,
   "role" role_enum NOT NULL DEFAULT 'customer',
  "createdAt" time,
  "updatedAt" time
);

CREATE TABLE "stores" (
 "id" integer PRIMARY KEY,
  "uid" uuid REFERENCES "users" ("id") ON DELETE CASCADE,
  "name" text,
  "profilePicture" text,
  "createdAt" time,
  "updatedAt" time,
  "type" text
);

CREATE TABLE "workingHours"(
  "id" uuid PRIMARY KEY gen_random_uuid(),
  "storeId" integer REFERENCES "stores" ("id") ON DELETE CASCADE,
  "opening" time NOT NULL,
  "closing" time NOT NULL,
  "day" text NOT NULL,
  "isOpen" bool NOT NULL
);

CREATE TABLE "categories" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "name" text NOT NULL
);

CREATE TABLE "posts" (
  "id" integer PRIMARY KEY,
  "name" text NOT NULL,
  "store" integer REFERENCES "stores" ("id") ON DELETE CASCADE,
  "price" float NOT NULL,
  "image" text,
  "type" uuid REFERENCES "categories" ("id") ON DELETE CASCADE,
  "likes" integer,
  "imageUrl" text
);

CREATE TABLE "likes" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "postId" SERIAL REFERENCES "posts" ("id") ON DELETE CASCADE,
  "uid" uuid REFERENCES "users" ("id") ON DELETE CASCADE,
  "createdAt" time
);



CREATE TABLE "addresses"(
  "id" SERIAL PRIMARY KEY,
  "uid" uuid REFERENCES "users" ("id") ON DELETE CASCADE,
  "latitude" float NOT NULL,
  "longitude" float NOT NULL,
  "street" text NOT NULL,
  "city" text NOT NULL,
  "state" text NOT NULL,
  "zip" text NOT NULL,
  "createdAt" time,
  "updatedAt" time
);

CREATE TABLE "orders"(
  "id" SERIAL PRIMARY KEY,
  "uid" uuid REFERENCES "users" ("id") ON DELETE CASCADE,
  "storeId" integer REFERENCES "stores" ("id") ON DELETE CASCADE,
  "addressId" integer REFERENCES "addresses" ("id") ON DELETE CASCADE,
  "total" float NOT NULL,
  "currency" text NOT NULL,
  "status" text NOT NULL,
  "createdAt" time,
  "updatedAt" time
);

CREATE TABLE ingredients (
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL
);

CREATE TABLE post_ingredients (
  "postId" INTEGER REFERENCES posts(id) ON DELETE CASCADE,
  ingredient_id INTEGER REFERENCES ingredients(id) ON DELETE CASCADE,
  PRIMARY KEY ("postId", ingredient_id)
);

CREATE TABLE "post_categories" (
  "postId" integer REFERENCES "posts" ("id") ON DELETE CASCADE,
  "categoryId" uuid REFERENCES "categories" ("id") ON DELETE CASCADE,
  PRIMARY KEY ("postId", "categoryId")
);

CREATE TABLE "order_items" (
  "id" SERIAL PRIMARY KEY,
  "name" text NOT NULL,
  "store" integer REFERENCES "stores" ("id") ON DELETE CASCADE,
  "orderId" integer REFERENCES "orders" ("id") ON DELETE CASCADE,
  "price" float NOT NULL,
  "image" text,
  "type" text,
  "likes" integer,
  "imageUrl" text
);

ALTER TABLE "users" ADD CONSTRAINT unique_email UNIQUE (email);
ALTER TABLE "users" ADD CONSTRAINT unique_userName UNIQUE ("userName");
ALTER TABLE "likes" ADD CONSTRAINT unique_like UNIQUE ("postId", "uid");
ALTER TABLE "orders" ADD CONSTRAINT unique_order UNIQUE ("uid", "storeId");

ALTER TABLE "posts" ADD FOREIGN KEY ("store") REFERENCES "stores" ("id");
ALTER TABLE "posts" ADD FOREIGN KEY ("type") REFERENCES "categories" ("id");

ALTER TABLE "likes" ADD FOREIGN KEY ("postId") REFERENCES "posts" ("id");
ALTER TABLE "likes" ADD FOREIGN KEY ("uid") REFERENCES "users" ("id");    

-- Fetch posts with Mozzarella ingredient
SELECT p.* 
FROM posts p
JOIN post_ingredients pi ON p.id = "pi"."postId"
JOIN ingredients i ON pi.ingredient_id = i.id
WHERE i.name = 'Peperoni';

-- Fetch posts with pizza category
SELECT p.* 
FROM posts p
JOIN post_categories pc ON p.id = "pc"."postId"
JOIN categories c ON "pc"."categoryId" = c.id
WHERE c.name = 'pizza';

-- Fetch posts with pizza category and Mozzarella ingredient
SELECT p.* 
FROM posts p
JOIN post_categories pc ON p.id = pc.post_id
JOIN categories c ON "pc"."categoryId" = c.id;
JOIN post_ingredients pi ON p.id = "pi"."postId"
JOIN ingredients i ON pi.ingredient_id = i.id
WHERE c.name = 'pizza' AND i.name = 'Mozzarella';

-- Fetch posts and its ingredients
SELECT p.*, i.name
FROM posts p
JOIN post_ingredients pi ON p.id = "pi"."postId"
JOIN ingredients i ON pi.ingredient_id = i.id;

-- Fetch posts and its categories
SELECT p.*, c.name
FROM posts p
JOIN post_categories pc ON p.id = "pc"."postId"
JOIN categories c ON "pc"."categoryId" = c.id;

-- Fetch posts and its categories and ingredients
SELECT p.*, c.name, i.name
FROM posts p
JOIN post_categories pc ON p.id = "pc"."postId"
JOIN categories c ON "pc"."categoryId" = c.id
JOIN post_ingredients pi ON p.id = "pi"."postId"
JOIN ingredients i ON pi.ingredient_id = i.id;  

-- Fetch the store details of a specific post
SELECT s.*
FROM stores s
JOIN posts p ON s.id = p.store
WHERE p.id = 1;

-- Fetch specific post and its categories
SELECT p.*, c.name
FROM posts p
JOIN post_categories pc ON p.id = "pc"."postId"
JOIN categories c ON "pc"."categoryId" = c.id
WHERE p.id = 1;

-- Fetch ingredients of a specific post
SELECT i.name
FROM post_ingredients pi
JOIN ingredients i ON pi.ingredient_id = i.id
WHERE "pi"."postId" = 1;

-- Fetch categories of a specific post
SELECT c.name
FROM post_categories pc
JOIN categories c ON "pc"."categoryId" = c.id
WHERE "pc"."postId" = 1;

-- Fetch specific post and its categories and ingredients
SELECT p.*, c.name, i.name
FROM posts p
JOIN post_categories pc ON p.id = "pc"."postId"
JOIN categories c ON "pc"."categoryId" = c.id
JOIN post_ingredients pi ON p.id = "pi"."postId"
JOIN ingredients i ON pi.ingredient_id = i.id
WHERE p.id = 1;

-- Fetch store details only from store id
SELECT s.*
FROM stores s
WHERE s.id = 1;

-- Fetch working hours only from store id
SELECT w.*
FROM "workingHours" w
WHERE w."storeId" = 1;

-- Fetch all stores on a particular day
SELECT s.*
FROM stores s
JOIN "workingHours" w ON s.id = "w"."storeId"
WHERE w.day = 'Monday';

-- Fetch store details and its working hours
SELECT s.*, w.opening, w.closing, w.day, "w"."isOpen"
FROM stores s
JOIN "workingHours" w ON s.id = "w"."storeId";

-- Fetch store's posts
SELECT p.*
FROM posts p
WHERE p.store = 1;

-- Fetch store's posts and its categories
SELECT p.*, c.name
FROM posts p
JOIN post_categories pc ON p.id = "pc"."postId"
JOIN categories c ON "pc"."categoryId" = c.id
WHERE p.store = 1;

-- Fetch user from uid
SELECT u.*
FROM users u
WHERE u.id = '1ae4924d-ad53-4d16-ac8c-922cc19e0119';

-- Fetch user from email
SELECT u.*
FROM users u
WHERE u.email = 'bryan@test.com';

-- Fetch user's stores
SELECT s.*
FROM stores s
WHERE s.uid = '1ae4924d-ad53-4d16-ac8c-922cc19e0119';

