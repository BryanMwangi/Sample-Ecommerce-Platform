//Bookstore table
Table users {
  id integer [primary key]
  username varchar
  role varchar
  created_at timestamp
}
Table roles{
  id varchar [primary key]
  can_order bool
}
table addresses{
  id integer [primary key]
  user_id integer
  street varchar
  city varchar
  country varchar
  postal_code varchar
}

Table books{
  id integer [primary key]
  title varchar
  publish_year varchar
  exemplar varchar
}

Table authors{
  id integer [primary key]
  name varchar
}

table book_authors{
  book_id integer [primary key]
  author_id integer
}
table exemplars{
  exemplar varchar [primary key]
  author_id integer
}

Table orders{
  id integer [primary key]
  user_id integer
  address_id integer
}

table order_items{
  id integer [primary key]
  order_id integer
  user_id integer
  book_id integer

}
//let us describe users addesses roles
Ref: users.role < roles.id
Ref: addresses.user_id> users.id
//books and author relationships
Ref: book_authors.book_id > authors.id
Ref: book_authors.book_id > books.id
Ref: book_authors.author_id > authors.id
Ref: books.id > authors.id 
Ref: exemplars.exemplar< books.exemplar
Ref: exemplars.author_id> authors.id
//order order items and users relationships
Ref: orders.user_id < users.id
Ref: orders.address_id < addresses.id
Ref: order_items.order_id > orders.id
Ref: order_items.user_id> users.id //allows us to simply query all the orders made by the user
Ref: order_items.book_id < books.id
