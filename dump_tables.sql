--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg120+1)
-- Dumped by pg_dump version 16.4 (Debian 16.4-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.addresses (
    id integer NOT NULL,
    uid uuid,
    latitude double precision NOT NULL,
    longitude double precision NOT NULL,
    street text NOT NULL,
    city text NOT NULL,
    state text NOT NULL,
    zip text NOT NULL,
    "createdAt" time without time zone,
    "updatedAt" time without time zone
);


ALTER TABLE public.addresses OWNER TO doadmin;

--
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.addresses_id_seq OWNER TO doadmin;

--
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.categories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.categories OWNER TO doadmin;

--
-- Name: ingredients; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.ingredients (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.ingredients OWNER TO doadmin;

--
-- Name: ingredients_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.ingredients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ingredients_id_seq OWNER TO doadmin;

--
-- Name: ingredients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.ingredients_id_seq OWNED BY public.ingredients.id;


--
-- Name: likes; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.likes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "postId" integer NOT NULL,
    uid uuid,
    "createdAt" time without time zone
);


ALTER TABLE public.likes OWNER TO doadmin;

--
-- Name: likes_postId_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public."likes_postId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."likes_postId_seq" OWNER TO doadmin;

--
-- Name: likes_postId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public."likes_postId_seq" OWNED BY public.likes."postId";


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    name text NOT NULL,
    store integer,
    "orderId" integer,
    price double precision NOT NULL,
    image text,
    type text,
    likes integer,
    "imageUrl" text
);


ALTER TABLE public.order_items OWNER TO doadmin;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO doadmin;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    uid uuid,
    "storeId" integer,
    "addressId" integer,
    total double precision NOT NULL,
    currency text NOT NULL,
    status text NOT NULL,
    "createdAt" time without time zone,
    "updatedAt" time without time zone
);


ALTER TABLE public.orders OWNER TO doadmin;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO doadmin;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: post_categories; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.post_categories (
    "postId" integer NOT NULL,
    "categoryId" uuid NOT NULL
);


ALTER TABLE public.post_categories OWNER TO doadmin;

--
-- Name: post_ingredients; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.post_ingredients (
    "postId" integer NOT NULL,
    ingredient_id integer NOT NULL
);


ALTER TABLE public.post_ingredients OWNER TO doadmin;

--
-- Name: posts; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    store integer,
    price double precision NOT NULL,
    image text,
    type uuid,
    likes integer DEFAULT 0,
    "imageUrl" text NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.posts OWNER TO doadmin;

--
-- Name: stores; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.stores (
    id integer NOT NULL,
    uid uuid,
    name text,
    "profilePicture" text,
    "createdAt" time without time zone,
    "updatedAt" time without time zone,
    type text
);


ALTER TABLE public.stores OWNER TO doadmin;

--
-- Name: stores_id_seq; Type: SEQUENCE; Schema: public; Owner: doadmin
--

CREATE SEQUENCE public.stores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stores_id_seq OWNER TO doadmin;

--
-- Name: stores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doadmin
--

ALTER SEQUENCE public.stores_id_seq OWNED BY public.stores.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: doadmin
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text,
    "userName" text,
    "displayName" text NOT NULL,
    deleted boolean DEFAULT false,
    "phoneNumber" text,
    "profilePicture" text,
    role public.role_enum DEFAULT 'customer'::public.role_enum NOT NULL,
    "createdAt" time without time zone,
    "updatedAt" time without time zone
);


ALTER TABLE public.users OWNER TO doadmin;

--
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);


--
-- Name: ingredients id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.ingredients ALTER COLUMN id SET DEFAULT nextval('public.ingredients_id_seq'::regclass);


--
-- Name: likes postId; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.likes ALTER COLUMN "postId" SET DEFAULT nextval('public."likes_postId_seq"'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: stores id; Type: DEFAULT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.stores ALTER COLUMN id SET DEFAULT nextval('public.stores_id_seq'::regclass);


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: doadmin
--

COPY public.addresses (id, uid, latitude, longitude, street, city, state, zip, "createdAt", "updatedAt") FROM stdin;
1	55519ba4-342a-4574-956e-f0af1b428970	0	0	Piac utca 56, Floor 2 Door 5	Debrecen	4024	HU	03:05:35.487342	03:05:35.487342
2	55519ba4-342a-4574-956e-f0af1b428970	0	0	Piac Street 56, 56	Debrecen	4024	HU	03:10:57.725114	03:10:57.725114
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: doadmin
--

COPY public.categories (id, name) FROM stdin;
4488fc9d-c634-4641-9507-4e9baaa94bee	pizza
ed21c4cf-4d54-433f-a9fa-5301a3672791	burger
8c9df06e-f840-42ae-ad2f-e08af1ab330f	sushi
3e2bc231-5b10-4630-970b-dcb4dedc719d	frozen_meal
173dd032-3d05-4927-b635-17bc8af6a6a0	appetizer
1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	dessert
7d985363-18f2-4e60-8bba-e53f3975b083	pastry
\.


--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: doadmin
--

COPY public.ingredients (id, name) FROM stdin;
1	Mozarella
2	Peperoni
3	Tomatoes
4	BBQ sauce
5	Corn
6	Onion
7	Mushrooms
8	Bavarian sausages
9	Chicken
10	Pineapple
11	Cheese
12	Caramelized onions
13	Original sauce
14	Cheese cheddar
15	Bacon
16	Onion rings
17	Salmon
18	Nori
19	Rice
20	Cucumber
21	Cream cheese
22	Unagi sauce
23	Japanese tamago
24	Pasta
25	Meat
26	Mayo
27	Garlic
28	Basil
29	Flour
30	Peas
31	Carrots
32	Chili Pepper
33	Peanuts
34	Grapes
35	Strawberry
36	Butter
37	Cottage Cheese
38	Sugar
39	Potatoes
40	Milk
\.


--
-- Data for Name: likes; Type: TABLE DATA; Schema: public; Owner: doadmin
--

COPY public.likes (id, "postId", uid, "createdAt") FROM stdin;
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: doadmin
--

COPY public.order_items (id, name, store, "orderId", price, image, type, likes, "imageUrl") FROM stdin;
1	Pizza Hawaiian	1	5	7.43	\N	\N	\N	https://images.unsplash.com/photo-1528830984461-4d5c3cc1abf0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBIYXdhaWlhbiUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2Nnww&ixlib=rb-4.0.3&q=80&w=1080
2	Pizza Hawaiian	1	7	7.43	\N	\N	\N	https://images.unsplash.com/photo-1528830984461-4d5c3cc1abf0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBIYXdhaWlhbiUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2Nnww&ixlib=rb-4.0.3&q=80&w=1080
3	Pizza Hawaiian	1	8	7.43	\N	\N	\N	https://images.unsplash.com/photo-1528830984461-4d5c3cc1abf0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBIYXdhaWlhbiUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2Nnww&ixlib=rb-4.0.3&q=80&w=1080
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: doadmin
--

COPY public.orders (id, uid, "storeId", "addressId", total, currency, status, "createdAt", "updatedAt") FROM stdin;
5	55519ba4-342a-4574-956e-f0af1b428970	1	2	7.43	USD	pending	03:38:16.815787	03:38:16.815787
7	55519ba4-342a-4574-956e-f0af1b428970	1	2	7.43	USD	pending	03:41:51.621294	03:41:51.621294
8	55519ba4-342a-4574-956e-f0af1b428970	1	1	7.43	USD	pending	03:43:00.40608	03:43:00.40608
\.


--
-- Data for Name: post_categories; Type: TABLE DATA; Schema: public; Owner: doadmin
--

COPY public.post_categories ("postId", "categoryId") FROM stdin;
1	4488fc9d-c634-4641-9507-4e9baaa94bee
2	4488fc9d-c634-4641-9507-4e9baaa94bee
3	4488fc9d-c634-4641-9507-4e9baaa94bee
4	ed21c4cf-4d54-433f-a9fa-5301a3672791
5	ed21c4cf-4d54-433f-a9fa-5301a3672791
6	ed21c4cf-4d54-433f-a9fa-5301a3672791
7	4488fc9d-c634-4641-9507-4e9baaa94bee
8	4488fc9d-c634-4641-9507-4e9baaa94bee
9	4488fc9d-c634-4641-9507-4e9baaa94bee
10	8c9df06e-f840-42ae-ad2f-e08af1ab330f
11	8c9df06e-f840-42ae-ad2f-e08af1ab330f
12	8c9df06e-f840-42ae-ad2f-e08af1ab330f
13	3e2bc231-5b10-4630-970b-dcb4dedc719d
14	3e2bc231-5b10-4630-970b-dcb4dedc719d
15	3e2bc231-5b10-4630-970b-dcb4dedc719d
16	3e2bc231-5b10-4630-970b-dcb4dedc719d
17	173dd032-3d05-4927-b635-17bc8af6a6a0
18	173dd032-3d05-4927-b635-17bc8af6a6a0
19	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
20	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
21	7d985363-18f2-4e60-8bba-e53f3975b083
5694	3e2bc231-5b10-4630-970b-dcb4dedc719d
4160	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3057	8c9df06e-f840-42ae-ad2f-e08af1ab330f
4362	4488fc9d-c634-4641-9507-4e9baaa94bee
9196	8c9df06e-f840-42ae-ad2f-e08af1ab330f
7109	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
4584	8c9df06e-f840-42ae-ad2f-e08af1ab330f
1889	ed21c4cf-4d54-433f-a9fa-5301a3672791
8171	3e2bc231-5b10-4630-970b-dcb4dedc719d
1363	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8791	ed21c4cf-4d54-433f-a9fa-5301a3672791
5584	3e2bc231-5b10-4630-970b-dcb4dedc719d
7786	4488fc9d-c634-4641-9507-4e9baaa94bee
7805	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
4013	8c9df06e-f840-42ae-ad2f-e08af1ab330f
6513	4488fc9d-c634-4641-9507-4e9baaa94bee
6534	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
5946	3e2bc231-5b10-4630-970b-dcb4dedc719d
7634	4488fc9d-c634-4641-9507-4e9baaa94bee
270	ed21c4cf-4d54-433f-a9fa-5301a3672791
8016	4488fc9d-c634-4641-9507-4e9baaa94bee
1238	4488fc9d-c634-4641-9507-4e9baaa94bee
6561	8c9df06e-f840-42ae-ad2f-e08af1ab330f
7795	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
5511	3e2bc231-5b10-4630-970b-dcb4dedc719d
7756	3e2bc231-5b10-4630-970b-dcb4dedc719d
5118	ed21c4cf-4d54-433f-a9fa-5301a3672791
840	3e2bc231-5b10-4630-970b-dcb4dedc719d
757	ed21c4cf-4d54-433f-a9fa-5301a3672791
5780	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9310	3e2bc231-5b10-4630-970b-dcb4dedc719d
6582	ed21c4cf-4d54-433f-a9fa-5301a3672791
5794	8c9df06e-f840-42ae-ad2f-e08af1ab330f
4743	4488fc9d-c634-4641-9507-4e9baaa94bee
7516	3e2bc231-5b10-4630-970b-dcb4dedc719d
4414	3e2bc231-5b10-4630-970b-dcb4dedc719d
3179	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8890	4488fc9d-c634-4641-9507-4e9baaa94bee
2489	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9617	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9671	ed21c4cf-4d54-433f-a9fa-5301a3672791
6184	ed21c4cf-4d54-433f-a9fa-5301a3672791
788	ed21c4cf-4d54-433f-a9fa-5301a3672791
7395	ed21c4cf-4d54-433f-a9fa-5301a3672791
1015	3e2bc231-5b10-4630-970b-dcb4dedc719d
6105	ed21c4cf-4d54-433f-a9fa-5301a3672791
5260	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
7947	ed21c4cf-4d54-433f-a9fa-5301a3672791
1723	4488fc9d-c634-4641-9507-4e9baaa94bee
6365	3e2bc231-5b10-4630-970b-dcb4dedc719d
6165	8c9df06e-f840-42ae-ad2f-e08af1ab330f
1582	3e2bc231-5b10-4630-970b-dcb4dedc719d
5579	3e2bc231-5b10-4630-970b-dcb4dedc719d
512	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
5777	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
5395	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8707	3e2bc231-5b10-4630-970b-dcb4dedc719d
3110	4488fc9d-c634-4641-9507-4e9baaa94bee
9612	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
5416	3e2bc231-5b10-4630-970b-dcb4dedc719d
3520	4488fc9d-c634-4641-9507-4e9baaa94bee
1359	8c9df06e-f840-42ae-ad2f-e08af1ab330f
3555	ed21c4cf-4d54-433f-a9fa-5301a3672791
3588	4488fc9d-c634-4641-9507-4e9baaa94bee
2551	8c9df06e-f840-42ae-ad2f-e08af1ab330f
718	3e2bc231-5b10-4630-970b-dcb4dedc719d
4314	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
5891	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3248	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3865	4488fc9d-c634-4641-9507-4e9baaa94bee
987	8c9df06e-f840-42ae-ad2f-e08af1ab330f
6965	8c9df06e-f840-42ae-ad2f-e08af1ab330f
4360	4488fc9d-c634-4641-9507-4e9baaa94bee
968	3e2bc231-5b10-4630-970b-dcb4dedc719d
8904	8c9df06e-f840-42ae-ad2f-e08af1ab330f
2545	8c9df06e-f840-42ae-ad2f-e08af1ab330f
6771	4488fc9d-c634-4641-9507-4e9baaa94bee
9801	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3564	4488fc9d-c634-4641-9507-4e9baaa94bee
5327	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
5334	ed21c4cf-4d54-433f-a9fa-5301a3672791
7320	ed21c4cf-4d54-433f-a9fa-5301a3672791
709	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
793	3e2bc231-5b10-4630-970b-dcb4dedc719d
7370	4488fc9d-c634-4641-9507-4e9baaa94bee
6734	ed21c4cf-4d54-433f-a9fa-5301a3672791
2018	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
234	3e2bc231-5b10-4630-970b-dcb4dedc719d
7827	8c9df06e-f840-42ae-ad2f-e08af1ab330f
2598	8c9df06e-f840-42ae-ad2f-e08af1ab330f
3476	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3374	ed21c4cf-4d54-433f-a9fa-5301a3672791
1107	8c9df06e-f840-42ae-ad2f-e08af1ab330f
6839	3e2bc231-5b10-4630-970b-dcb4dedc719d
5488	4488fc9d-c634-4641-9507-4e9baaa94bee
9938	3e2bc231-5b10-4630-970b-dcb4dedc719d
499	4488fc9d-c634-4641-9507-4e9baaa94bee
5001	8c9df06e-f840-42ae-ad2f-e08af1ab330f
6114	4488fc9d-c634-4641-9507-4e9baaa94bee
4251	8c9df06e-f840-42ae-ad2f-e08af1ab330f
4767	3e2bc231-5b10-4630-970b-dcb4dedc719d
2350	8c9df06e-f840-42ae-ad2f-e08af1ab330f
3480	4488fc9d-c634-4641-9507-4e9baaa94bee
5701	3e2bc231-5b10-4630-970b-dcb4dedc719d
3494	4488fc9d-c634-4641-9507-4e9baaa94bee
410	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
6827	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
5740	ed21c4cf-4d54-433f-a9fa-5301a3672791
9379	3e2bc231-5b10-4630-970b-dcb4dedc719d
4428	4488fc9d-c634-4641-9507-4e9baaa94bee
9142	3e2bc231-5b10-4630-970b-dcb4dedc719d
2216	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
4395	3e2bc231-5b10-4630-970b-dcb4dedc719d
4552	8c9df06e-f840-42ae-ad2f-e08af1ab330f
5679	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9445	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
4412	4488fc9d-c634-4641-9507-4e9baaa94bee
3268	ed21c4cf-4d54-433f-a9fa-5301a3672791
3598	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
2552	8c9df06e-f840-42ae-ad2f-e08af1ab330f
5429	4488fc9d-c634-4641-9507-4e9baaa94bee
2771	ed21c4cf-4d54-433f-a9fa-5301a3672791
6903	ed21c4cf-4d54-433f-a9fa-5301a3672791
5431	4488fc9d-c634-4641-9507-4e9baaa94bee
7055	3e2bc231-5b10-4630-970b-dcb4dedc719d
7731	4488fc9d-c634-4641-9507-4e9baaa94bee
5868	ed21c4cf-4d54-433f-a9fa-5301a3672791
9481	4488fc9d-c634-4641-9507-4e9baaa94bee
2704	4488fc9d-c634-4641-9507-4e9baaa94bee
9984	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
1761	4488fc9d-c634-4641-9507-4e9baaa94bee
5086	4488fc9d-c634-4641-9507-4e9baaa94bee
797	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8417	ed21c4cf-4d54-433f-a9fa-5301a3672791
2526	8c9df06e-f840-42ae-ad2f-e08af1ab330f
1465	4488fc9d-c634-4641-9507-4e9baaa94bee
6692	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8450	8c9df06e-f840-42ae-ad2f-e08af1ab330f
2202	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8273	ed21c4cf-4d54-433f-a9fa-5301a3672791
1930	ed21c4cf-4d54-433f-a9fa-5301a3672791
7777	3e2bc231-5b10-4630-970b-dcb4dedc719d
8793	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9000	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
1398	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
4377	8c9df06e-f840-42ae-ad2f-e08af1ab330f
7483	4488fc9d-c634-4641-9507-4e9baaa94bee
8045	4488fc9d-c634-4641-9507-4e9baaa94bee
2330	4488fc9d-c634-4641-9507-4e9baaa94bee
6927	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9557	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
931	8c9df06e-f840-42ae-ad2f-e08af1ab330f
991	3e2bc231-5b10-4630-970b-dcb4dedc719d
668	ed21c4cf-4d54-433f-a9fa-5301a3672791
1788	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8456	ed21c4cf-4d54-433f-a9fa-5301a3672791
7907	3e2bc231-5b10-4630-970b-dcb4dedc719d
6462	4488fc9d-c634-4641-9507-4e9baaa94bee
1623	8c9df06e-f840-42ae-ad2f-e08af1ab330f
4690	3e2bc231-5b10-4630-970b-dcb4dedc719d
446	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
4363	4488fc9d-c634-4641-9507-4e9baaa94bee
3513	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9380	ed21c4cf-4d54-433f-a9fa-5301a3672791
1319	3e2bc231-5b10-4630-970b-dcb4dedc719d
2576	3e2bc231-5b10-4630-970b-dcb4dedc719d
1285	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3738	3e2bc231-5b10-4630-970b-dcb4dedc719d
6733	8c9df06e-f840-42ae-ad2f-e08af1ab330f
6689	ed21c4cf-4d54-433f-a9fa-5301a3672791
2326	8c9df06e-f840-42ae-ad2f-e08af1ab330f
3754	8c9df06e-f840-42ae-ad2f-e08af1ab330f
2171	4488fc9d-c634-4641-9507-4e9baaa94bee
8755	4488fc9d-c634-4641-9507-4e9baaa94bee
4009	ed21c4cf-4d54-433f-a9fa-5301a3672791
5538	ed21c4cf-4d54-433f-a9fa-5301a3672791
176	4488fc9d-c634-4641-9507-4e9baaa94bee
7431	4488fc9d-c634-4641-9507-4e9baaa94bee
9047	8c9df06e-f840-42ae-ad2f-e08af1ab330f
4882	8c9df06e-f840-42ae-ad2f-e08af1ab330f
3929	8c9df06e-f840-42ae-ad2f-e08af1ab330f
496	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8674	ed21c4cf-4d54-433f-a9fa-5301a3672791
8105	3e2bc231-5b10-4630-970b-dcb4dedc719d
7234	ed21c4cf-4d54-433f-a9fa-5301a3672791
9460	4488fc9d-c634-4641-9507-4e9baaa94bee
9645	ed21c4cf-4d54-433f-a9fa-5301a3672791
9930	ed21c4cf-4d54-433f-a9fa-5301a3672791
3301	ed21c4cf-4d54-433f-a9fa-5301a3672791
2943	3e2bc231-5b10-4630-970b-dcb4dedc719d
7192	4488fc9d-c634-4641-9507-4e9baaa94bee
3690	4488fc9d-c634-4641-9507-4e9baaa94bee
5427	ed21c4cf-4d54-433f-a9fa-5301a3672791
3364	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
6782	ed21c4cf-4d54-433f-a9fa-5301a3672791
9945	4488fc9d-c634-4641-9507-4e9baaa94bee
5102	4488fc9d-c634-4641-9507-4e9baaa94bee
6309	8c9df06e-f840-42ae-ad2f-e08af1ab330f
7563	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
5226	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9660	ed21c4cf-4d54-433f-a9fa-5301a3672791
3043	3e2bc231-5b10-4630-970b-dcb4dedc719d
9462	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
9285	3e2bc231-5b10-4630-970b-dcb4dedc719d
203	4488fc9d-c634-4641-9507-4e9baaa94bee
2151	3e2bc231-5b10-4630-970b-dcb4dedc719d
9393	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
1564	ed21c4cf-4d54-433f-a9fa-5301a3672791
5845	3e2bc231-5b10-4630-970b-dcb4dedc719d
4653	ed21c4cf-4d54-433f-a9fa-5301a3672791
7134	8c9df06e-f840-42ae-ad2f-e08af1ab330f
4894	3e2bc231-5b10-4630-970b-dcb4dedc719d
3818	8c9df06e-f840-42ae-ad2f-e08af1ab330f
4588	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8316	3e2bc231-5b10-4630-970b-dcb4dedc719d
3566	4488fc9d-c634-4641-9507-4e9baaa94bee
3713	ed21c4cf-4d54-433f-a9fa-5301a3672791
4639	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
1035	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3607	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
4350	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
4080	4488fc9d-c634-4641-9507-4e9baaa94bee
2924	ed21c4cf-4d54-433f-a9fa-5301a3672791
4505	ed21c4cf-4d54-433f-a9fa-5301a3672791
9689	4488fc9d-c634-4641-9507-4e9baaa94bee
8443	ed21c4cf-4d54-433f-a9fa-5301a3672791
7638	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
6012	3e2bc231-5b10-4630-970b-dcb4dedc719d
5284	8c9df06e-f840-42ae-ad2f-e08af1ab330f
4908	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8055	4488fc9d-c634-4641-9507-4e9baaa94bee
3671	ed21c4cf-4d54-433f-a9fa-5301a3672791
9913	ed21c4cf-4d54-433f-a9fa-5301a3672791
8680	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8583	8c9df06e-f840-42ae-ad2f-e08af1ab330f
5293	3e2bc231-5b10-4630-970b-dcb4dedc719d
4158	8c9df06e-f840-42ae-ad2f-e08af1ab330f
5353	3e2bc231-5b10-4630-970b-dcb4dedc719d
2868	4488fc9d-c634-4641-9507-4e9baaa94bee
4553	ed21c4cf-4d54-433f-a9fa-5301a3672791
2822	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
9020	ed21c4cf-4d54-433f-a9fa-5301a3672791
346	8c9df06e-f840-42ae-ad2f-e08af1ab330f
4291	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
106	4488fc9d-c634-4641-9507-4e9baaa94bee
287	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
9961	ed21c4cf-4d54-433f-a9fa-5301a3672791
8679	4488fc9d-c634-4641-9507-4e9baaa94bee
2275	4488fc9d-c634-4641-9507-4e9baaa94bee
1116	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
4475	4488fc9d-c634-4641-9507-4e9baaa94bee
4470	8c9df06e-f840-42ae-ad2f-e08af1ab330f
3492	3e2bc231-5b10-4630-970b-dcb4dedc719d
2230	ed21c4cf-4d54-433f-a9fa-5301a3672791
1223	ed21c4cf-4d54-433f-a9fa-5301a3672791
9527	ed21c4cf-4d54-433f-a9fa-5301a3672791
4543	3e2bc231-5b10-4630-970b-dcb4dedc719d
2477	4488fc9d-c634-4641-9507-4e9baaa94bee
1675	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9656	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
6368	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
2985	4488fc9d-c634-4641-9507-4e9baaa94bee
7310	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
6583	4488fc9d-c634-4641-9507-4e9baaa94bee
5176	4488fc9d-c634-4641-9507-4e9baaa94bee
2214	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3526	ed21c4cf-4d54-433f-a9fa-5301a3672791
8059	ed21c4cf-4d54-433f-a9fa-5301a3672791
4286	8c9df06e-f840-42ae-ad2f-e08af1ab330f
3499	ed21c4cf-4d54-433f-a9fa-5301a3672791
1425	3e2bc231-5b10-4630-970b-dcb4dedc719d
6305	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
7385	ed21c4cf-4d54-433f-a9fa-5301a3672791
2700	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8950	4488fc9d-c634-4641-9507-4e9baaa94bee
7999	8c9df06e-f840-42ae-ad2f-e08af1ab330f
5910	3e2bc231-5b10-4630-970b-dcb4dedc719d
1953	ed21c4cf-4d54-433f-a9fa-5301a3672791
8610	8c9df06e-f840-42ae-ad2f-e08af1ab330f
3907	4488fc9d-c634-4641-9507-4e9baaa94bee
3618	ed21c4cf-4d54-433f-a9fa-5301a3672791
5687	3e2bc231-5b10-4630-970b-dcb4dedc719d
8107	ed21c4cf-4d54-433f-a9fa-5301a3672791
6145	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8099	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
9574	4488fc9d-c634-4641-9507-4e9baaa94bee
9207	3e2bc231-5b10-4630-970b-dcb4dedc719d
4387	3e2bc231-5b10-4630-970b-dcb4dedc719d
5731	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
2067	3e2bc231-5b10-4630-970b-dcb4dedc719d
6213	4488fc9d-c634-4641-9507-4e9baaa94bee
9114	3e2bc231-5b10-4630-970b-dcb4dedc719d
7477	3e2bc231-5b10-4630-970b-dcb4dedc719d
9956	ed21c4cf-4d54-433f-a9fa-5301a3672791
1860	3e2bc231-5b10-4630-970b-dcb4dedc719d
7241	ed21c4cf-4d54-433f-a9fa-5301a3672791
9133	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
5861	3e2bc231-5b10-4630-970b-dcb4dedc719d
5494	8c9df06e-f840-42ae-ad2f-e08af1ab330f
6552	4488fc9d-c634-4641-9507-4e9baaa94bee
5496	4488fc9d-c634-4641-9507-4e9baaa94bee
9302	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
9545	8c9df06e-f840-42ae-ad2f-e08af1ab330f
6476	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8432	ed21c4cf-4d54-433f-a9fa-5301a3672791
6367	3e2bc231-5b10-4630-970b-dcb4dedc719d
9653	4488fc9d-c634-4641-9507-4e9baaa94bee
756	3e2bc231-5b10-4630-970b-dcb4dedc719d
7202	4488fc9d-c634-4641-9507-4e9baaa94bee
9336	4488fc9d-c634-4641-9507-4e9baaa94bee
2530	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8871	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9267	ed21c4cf-4d54-433f-a9fa-5301a3672791
423	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8248	ed21c4cf-4d54-433f-a9fa-5301a3672791
945	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3208	3e2bc231-5b10-4630-970b-dcb4dedc719d
461	3e2bc231-5b10-4630-970b-dcb4dedc719d
5375	ed21c4cf-4d54-433f-a9fa-5301a3672791
1685	8c9df06e-f840-42ae-ad2f-e08af1ab330f
2247	4488fc9d-c634-4641-9507-4e9baaa94bee
600	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8887	3e2bc231-5b10-4630-970b-dcb4dedc719d
2916	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
1014	8c9df06e-f840-42ae-ad2f-e08af1ab330f
1642	8c9df06e-f840-42ae-ad2f-e08af1ab330f
7301	ed21c4cf-4d54-433f-a9fa-5301a3672791
8142	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3308	4488fc9d-c634-4641-9507-4e9baaa94bee
8054	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
830	ed21c4cf-4d54-433f-a9fa-5301a3672791
8314	4488fc9d-c634-4641-9507-4e9baaa94bee
8839	8c9df06e-f840-42ae-ad2f-e08af1ab330f
6002	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
5992	4488fc9d-c634-4641-9507-4e9baaa94bee
4617	ed21c4cf-4d54-433f-a9fa-5301a3672791
4280	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
1290	4488fc9d-c634-4641-9507-4e9baaa94bee
7776	8c9df06e-f840-42ae-ad2f-e08af1ab330f
1841	3e2bc231-5b10-4630-970b-dcb4dedc719d
2748	8c9df06e-f840-42ae-ad2f-e08af1ab330f
4459	3e2bc231-5b10-4630-970b-dcb4dedc719d
4539	8c9df06e-f840-42ae-ad2f-e08af1ab330f
7783	3e2bc231-5b10-4630-970b-dcb4dedc719d
2960	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
95	4488fc9d-c634-4641-9507-4e9baaa94bee
5512	8c9df06e-f840-42ae-ad2f-e08af1ab330f
2101	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
6762	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
7610	3e2bc231-5b10-4630-970b-dcb4dedc719d
9966	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9841	3e2bc231-5b10-4630-970b-dcb4dedc719d
3502	3e2bc231-5b10-4630-970b-dcb4dedc719d
689	3e2bc231-5b10-4630-970b-dcb4dedc719d
4650	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
4127	ed21c4cf-4d54-433f-a9fa-5301a3672791
5950	3e2bc231-5b10-4630-970b-dcb4dedc719d
7622	ed21c4cf-4d54-433f-a9fa-5301a3672791
1454	4488fc9d-c634-4641-9507-4e9baaa94bee
3636	4488fc9d-c634-4641-9507-4e9baaa94bee
7082	3e2bc231-5b10-4630-970b-dcb4dedc719d
1534	ed21c4cf-4d54-433f-a9fa-5301a3672791
6042	3e2bc231-5b10-4630-970b-dcb4dedc719d
5702	8c9df06e-f840-42ae-ad2f-e08af1ab330f
1996	3e2bc231-5b10-4630-970b-dcb4dedc719d
2540	8c9df06e-f840-42ae-ad2f-e08af1ab330f
7761	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
2979	ed21c4cf-4d54-433f-a9fa-5301a3672791
6095	ed21c4cf-4d54-433f-a9fa-5301a3672791
3038	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3840	3e2bc231-5b10-4630-970b-dcb4dedc719d
4887	4488fc9d-c634-4641-9507-4e9baaa94bee
3456	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8987	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9374	ed21c4cf-4d54-433f-a9fa-5301a3672791
595	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
9121	8c9df06e-f840-42ae-ad2f-e08af1ab330f
5567	4488fc9d-c634-4641-9507-4e9baaa94bee
6522	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
398	4488fc9d-c634-4641-9507-4e9baaa94bee
3284	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3132	4488fc9d-c634-4641-9507-4e9baaa94bee
8991	4488fc9d-c634-4641-9507-4e9baaa94bee
3177	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8517	4488fc9d-c634-4641-9507-4e9baaa94bee
3956	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
776	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9901	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3626	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3827	3e2bc231-5b10-4630-970b-dcb4dedc719d
6469	8c9df06e-f840-42ae-ad2f-e08af1ab330f
5850	8c9df06e-f840-42ae-ad2f-e08af1ab330f
662	3e2bc231-5b10-4630-970b-dcb4dedc719d
8134	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
6457	3e2bc231-5b10-4630-970b-dcb4dedc719d
5421	ed21c4cf-4d54-433f-a9fa-5301a3672791
3006	3e2bc231-5b10-4630-970b-dcb4dedc719d
9357	4488fc9d-c634-4641-9507-4e9baaa94bee
3565	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9980	4488fc9d-c634-4641-9507-4e9baaa94bee
9325	3e2bc231-5b10-4630-970b-dcb4dedc719d
3643	3e2bc231-5b10-4630-970b-dcb4dedc719d
1109	ed21c4cf-4d54-433f-a9fa-5301a3672791
8289	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
9313	3e2bc231-5b10-4630-970b-dcb4dedc719d
9085	4488fc9d-c634-4641-9507-4e9baaa94bee
3623	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
997	3e2bc231-5b10-4630-970b-dcb4dedc719d
41	8c9df06e-f840-42ae-ad2f-e08af1ab330f
5937	ed21c4cf-4d54-433f-a9fa-5301a3672791
1316	8c9df06e-f840-42ae-ad2f-e08af1ab330f
514	4488fc9d-c634-4641-9507-4e9baaa94bee
4587	3e2bc231-5b10-4630-970b-dcb4dedc719d
7749	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
7488	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3906	ed21c4cf-4d54-433f-a9fa-5301a3672791
4510	8c9df06e-f840-42ae-ad2f-e08af1ab330f
6656	ed21c4cf-4d54-433f-a9fa-5301a3672791
4608	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8425	ed21c4cf-4d54-433f-a9fa-5301a3672791
3030	4488fc9d-c634-4641-9507-4e9baaa94bee
9840	ed21c4cf-4d54-433f-a9fa-5301a3672791
1247	3e2bc231-5b10-4630-970b-dcb4dedc719d
5816	8c9df06e-f840-42ae-ad2f-e08af1ab330f
7213	8c9df06e-f840-42ae-ad2f-e08af1ab330f
2548	4488fc9d-c634-4641-9507-4e9baaa94bee
3841	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9502	3e2bc231-5b10-4630-970b-dcb4dedc719d
3145	4488fc9d-c634-4641-9507-4e9baaa94bee
2483	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8962	ed21c4cf-4d54-433f-a9fa-5301a3672791
2255	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
4406	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
2813	4488fc9d-c634-4641-9507-4e9baaa94bee
8333	3e2bc231-5b10-4630-970b-dcb4dedc719d
1670	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
1074	3e2bc231-5b10-4630-970b-dcb4dedc719d
3734	4488fc9d-c634-4641-9507-4e9baaa94bee
3770	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
572	ed21c4cf-4d54-433f-a9fa-5301a3672791
4605	4488fc9d-c634-4641-9507-4e9baaa94bee
9390	3e2bc231-5b10-4630-970b-dcb4dedc719d
7628	ed21c4cf-4d54-433f-a9fa-5301a3672791
6679	8c9df06e-f840-42ae-ad2f-e08af1ab330f
5268	ed21c4cf-4d54-433f-a9fa-5301a3672791
4064	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
7913	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8057	3e2bc231-5b10-4630-970b-dcb4dedc719d
9401	3e2bc231-5b10-4630-970b-dcb4dedc719d
3352	ed21c4cf-4d54-433f-a9fa-5301a3672791
5877	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3013	ed21c4cf-4d54-433f-a9fa-5301a3672791
5153	8c9df06e-f840-42ae-ad2f-e08af1ab330f
3441	ed21c4cf-4d54-433f-a9fa-5301a3672791
172	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8651	ed21c4cf-4d54-433f-a9fa-5301a3672791
9810	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
9437	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3900	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
5781	4488fc9d-c634-4641-9507-4e9baaa94bee
1152	ed21c4cf-4d54-433f-a9fa-5301a3672791
8148	4488fc9d-c634-4641-9507-4e9baaa94bee
3888	3e2bc231-5b10-4630-970b-dcb4dedc719d
4760	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8738	8c9df06e-f840-42ae-ad2f-e08af1ab330f
6396	8c9df06e-f840-42ae-ad2f-e08af1ab330f
1968	8c9df06e-f840-42ae-ad2f-e08af1ab330f
2522	8c9df06e-f840-42ae-ad2f-e08af1ab330f
5765	4488fc9d-c634-4641-9507-4e9baaa94bee
8498	ed21c4cf-4d54-433f-a9fa-5301a3672791
9742	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
651	ed21c4cf-4d54-433f-a9fa-5301a3672791
4390	4488fc9d-c634-4641-9507-4e9baaa94bee
3260	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8114	ed21c4cf-4d54-433f-a9fa-5301a3672791
4901	3e2bc231-5b10-4630-970b-dcb4dedc719d
7729	3e2bc231-5b10-4630-970b-dcb4dedc719d
6161	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3726	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
1804	8c9df06e-f840-42ae-ad2f-e08af1ab330f
6780	3e2bc231-5b10-4630-970b-dcb4dedc719d
4907	ed21c4cf-4d54-433f-a9fa-5301a3672791
4554	3e2bc231-5b10-4630-970b-dcb4dedc719d
3710	ed21c4cf-4d54-433f-a9fa-5301a3672791
7365	4488fc9d-c634-4641-9507-4e9baaa94bee
7508	8c9df06e-f840-42ae-ad2f-e08af1ab330f
1940	3e2bc231-5b10-4630-970b-dcb4dedc719d
746	3e2bc231-5b10-4630-970b-dcb4dedc719d
3465	3e2bc231-5b10-4630-970b-dcb4dedc719d
447	4488fc9d-c634-4641-9507-4e9baaa94bee
8260	ed21c4cf-4d54-433f-a9fa-5301a3672791
5879	8c9df06e-f840-42ae-ad2f-e08af1ab330f
3930	4488fc9d-c634-4641-9507-4e9baaa94bee
2952	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8125	ed21c4cf-4d54-433f-a9fa-5301a3672791
6228	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
6294	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9733	4488fc9d-c634-4641-9507-4e9baaa94bee
7330	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
9858	3e2bc231-5b10-4630-970b-dcb4dedc719d
8025	ed21c4cf-4d54-433f-a9fa-5301a3672791
5497	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
5062	3e2bc231-5b10-4630-970b-dcb4dedc719d
7148	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
377	ed21c4cf-4d54-433f-a9fa-5301a3672791
1548	8c9df06e-f840-42ae-ad2f-e08af1ab330f
6723	8c9df06e-f840-42ae-ad2f-e08af1ab330f
2990	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
740	3e2bc231-5b10-4630-970b-dcb4dedc719d
7752	4488fc9d-c634-4641-9507-4e9baaa94bee
1683	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
5415	8c9df06e-f840-42ae-ad2f-e08af1ab330f
3876	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
6622	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8750	4488fc9d-c634-4641-9507-4e9baaa94bee
1568	ed21c4cf-4d54-433f-a9fa-5301a3672791
1481	8c9df06e-f840-42ae-ad2f-e08af1ab330f
6670	8c9df06e-f840-42ae-ad2f-e08af1ab330f
6907	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
5961	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8847	3e2bc231-5b10-4630-970b-dcb4dedc719d
8953	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8635	4488fc9d-c634-4641-9507-4e9baaa94bee
7274	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3985	4488fc9d-c634-4641-9507-4e9baaa94bee
3000	8c9df06e-f840-42ae-ad2f-e08af1ab330f
2367	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8936	3e2bc231-5b10-4630-970b-dcb4dedc719d
8678	8c9df06e-f840-42ae-ad2f-e08af1ab330f
2345	4488fc9d-c634-4641-9507-4e9baaa94bee
5312	ed21c4cf-4d54-433f-a9fa-5301a3672791
4225	3e2bc231-5b10-4630-970b-dcb4dedc719d
9640	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
4963	ed21c4cf-4d54-433f-a9fa-5301a3672791
4468	8c9df06e-f840-42ae-ad2f-e08af1ab330f
1309	ed21c4cf-4d54-433f-a9fa-5301a3672791
7209	3e2bc231-5b10-4630-970b-dcb4dedc719d
4567	3e2bc231-5b10-4630-970b-dcb4dedc719d
9163	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
1131	4488fc9d-c634-4641-9507-4e9baaa94bee
3469	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8631	3e2bc231-5b10-4630-970b-dcb4dedc719d
2415	3e2bc231-5b10-4630-970b-dcb4dedc719d
1078	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
7885	8c9df06e-f840-42ae-ad2f-e08af1ab330f
7026	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
7218	3e2bc231-5b10-4630-970b-dcb4dedc719d
9965	8c9df06e-f840-42ae-ad2f-e08af1ab330f
3271	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9710	4488fc9d-c634-4641-9507-4e9baaa94bee
8598	3e2bc231-5b10-4630-970b-dcb4dedc719d
7001	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
9200	3e2bc231-5b10-4630-970b-dcb4dedc719d
138	3e2bc231-5b10-4630-970b-dcb4dedc719d
9749	4488fc9d-c634-4641-9507-4e9baaa94bee
645	3e2bc231-5b10-4630-970b-dcb4dedc719d
173	4488fc9d-c634-4641-9507-4e9baaa94bee
554	ed21c4cf-4d54-433f-a9fa-5301a3672791
2139	ed21c4cf-4d54-433f-a9fa-5301a3672791
6813	8c9df06e-f840-42ae-ad2f-e08af1ab330f
4604	ed21c4cf-4d54-433f-a9fa-5301a3672791
9861	3e2bc231-5b10-4630-970b-dcb4dedc719d
2301	ed21c4cf-4d54-433f-a9fa-5301a3672791
2224	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
4230	8c9df06e-f840-42ae-ad2f-e08af1ab330f
3848	ed21c4cf-4d54-433f-a9fa-5301a3672791
9974	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9926	8c9df06e-f840-42ae-ad2f-e08af1ab330f
7332	3e2bc231-5b10-4630-970b-dcb4dedc719d
6055	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
7010	3e2bc231-5b10-4630-970b-dcb4dedc719d
7993	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3541	4488fc9d-c634-4641-9507-4e9baaa94bee
917	ed21c4cf-4d54-433f-a9fa-5301a3672791
6076	8c9df06e-f840-42ae-ad2f-e08af1ab330f
4858	8c9df06e-f840-42ae-ad2f-e08af1ab330f
1573	4488fc9d-c634-4641-9507-4e9baaa94bee
9871	ed21c4cf-4d54-433f-a9fa-5301a3672791
4644	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9914	8c9df06e-f840-42ae-ad2f-e08af1ab330f
5064	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8977	3e2bc231-5b10-4630-970b-dcb4dedc719d
1120	4488fc9d-c634-4641-9507-4e9baaa94bee
8380	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
9941	ed21c4cf-4d54-433f-a9fa-5301a3672791
9824	8c9df06e-f840-42ae-ad2f-e08af1ab330f
2835	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8158	8c9df06e-f840-42ae-ad2f-e08af1ab330f
3986	4488fc9d-c634-4641-9507-4e9baaa94bee
8208	3e2bc231-5b10-4630-970b-dcb4dedc719d
7492	8c9df06e-f840-42ae-ad2f-e08af1ab330f
6981	4488fc9d-c634-4641-9507-4e9baaa94bee
6223	4488fc9d-c634-4641-9507-4e9baaa94bee
2442	8c9df06e-f840-42ae-ad2f-e08af1ab330f
2601	3e2bc231-5b10-4630-970b-dcb4dedc719d
583	ed21c4cf-4d54-433f-a9fa-5301a3672791
7788	4488fc9d-c634-4641-9507-4e9baaa94bee
641	3e2bc231-5b10-4630-970b-dcb4dedc719d
6745	3e2bc231-5b10-4630-970b-dcb4dedc719d
6855	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8145	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
4063	3e2bc231-5b10-4630-970b-dcb4dedc719d
5590	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
5721	4488fc9d-c634-4641-9507-4e9baaa94bee
6024	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
5951	4488fc9d-c634-4641-9507-4e9baaa94bee
5842	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
2473	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9318	8c9df06e-f840-42ae-ad2f-e08af1ab330f
1507	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8870	ed21c4cf-4d54-433f-a9fa-5301a3672791
364	ed21c4cf-4d54-433f-a9fa-5301a3672791
2379	3e2bc231-5b10-4630-970b-dcb4dedc719d
5315	4488fc9d-c634-4641-9507-4e9baaa94bee
1237	3e2bc231-5b10-4630-970b-dcb4dedc719d
7085	ed21c4cf-4d54-433f-a9fa-5301a3672791
9113	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
1557	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8394	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
127	3e2bc231-5b10-4630-970b-dcb4dedc719d
5705	ed21c4cf-4d54-433f-a9fa-5301a3672791
6451	ed21c4cf-4d54-433f-a9fa-5301a3672791
5145	4488fc9d-c634-4641-9507-4e9baaa94bee
2810	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3049	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9019	ed21c4cf-4d54-433f-a9fa-5301a3672791
268	4488fc9d-c634-4641-9507-4e9baaa94bee
7292	3e2bc231-5b10-4630-970b-dcb4dedc719d
2080	3e2bc231-5b10-4630-970b-dcb4dedc719d
866	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
9981	ed21c4cf-4d54-433f-a9fa-5301a3672791
8213	3e2bc231-5b10-4630-970b-dcb4dedc719d
7296	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
218	ed21c4cf-4d54-433f-a9fa-5301a3672791
1837	4488fc9d-c634-4641-9507-4e9baaa94bee
7027	4488fc9d-c634-4641-9507-4e9baaa94bee
1110	ed21c4cf-4d54-433f-a9fa-5301a3672791
5172	ed21c4cf-4d54-433f-a9fa-5301a3672791
8747	4488fc9d-c634-4641-9507-4e9baaa94bee
7356	4488fc9d-c634-4641-9507-4e9baaa94bee
3400	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3080	8c9df06e-f840-42ae-ad2f-e08af1ab330f
1684	4488fc9d-c634-4641-9507-4e9baaa94bee
3508	8c9df06e-f840-42ae-ad2f-e08af1ab330f
3873	8c9df06e-f840-42ae-ad2f-e08af1ab330f
1910	3e2bc231-5b10-4630-970b-dcb4dedc719d
1844	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9063	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
2874	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
6342	4488fc9d-c634-4641-9507-4e9baaa94bee
9171	ed21c4cf-4d54-433f-a9fa-5301a3672791
5772	ed21c4cf-4d54-433f-a9fa-5301a3672791
6346	4488fc9d-c634-4641-9507-4e9baaa94bee
9697	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
159	4488fc9d-c634-4641-9507-4e9baaa94bee
4719	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8561	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9947	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3015	8c9df06e-f840-42ae-ad2f-e08af1ab330f
9556	3e2bc231-5b10-4630-970b-dcb4dedc719d
2556	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
3639	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
8578	8c9df06e-f840-42ae-ad2f-e08af1ab330f
7587	8c9df06e-f840-42ae-ad2f-e08af1ab330f
2420	8c9df06e-f840-42ae-ad2f-e08af1ab330f
6338	3e2bc231-5b10-4630-970b-dcb4dedc719d
5606	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8044	4488fc9d-c634-4641-9507-4e9baaa94bee
4309	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
899	ed21c4cf-4d54-433f-a9fa-5301a3672791
3402	3e2bc231-5b10-4630-970b-dcb4dedc719d
2941	8c9df06e-f840-42ae-ad2f-e08af1ab330f
6636	3e2bc231-5b10-4630-970b-dcb4dedc719d
3461	ed21c4cf-4d54-433f-a9fa-5301a3672791
1043	4488fc9d-c634-4641-9507-4e9baaa94bee
7917	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8100	ed21c4cf-4d54-433f-a9fa-5301a3672791
3829	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
6647	8c9df06e-f840-42ae-ad2f-e08af1ab330f
4730	3e2bc231-5b10-4630-970b-dcb4dedc719d
1422	4488fc9d-c634-4641-9507-4e9baaa94bee
78	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
4490	4488fc9d-c634-4641-9507-4e9baaa94bee
5393	4488fc9d-c634-4641-9507-4e9baaa94bee
5276	8c9df06e-f840-42ae-ad2f-e08af1ab330f
8003	4488fc9d-c634-4641-9507-4e9baaa94bee
5337	ed21c4cf-4d54-433f-a9fa-5301a3672791
3370	4488fc9d-c634-4641-9507-4e9baaa94bee
9146	ed21c4cf-4d54-433f-a9fa-5301a3672791
149	8c9df06e-f840-42ae-ad2f-e08af1ab330f
7106	4488fc9d-c634-4641-9507-4e9baaa94bee
1793	8c9df06e-f840-42ae-ad2f-e08af1ab330f
3377	3e2bc231-5b10-4630-970b-dcb4dedc719d
3944	8c9df06e-f840-42ae-ad2f-e08af1ab330f
457	3e2bc231-5b10-4630-970b-dcb4dedc719d
9788	ed21c4cf-4d54-433f-a9fa-5301a3672791
6192	3e2bc231-5b10-4630-970b-dcb4dedc719d
3430	3e2bc231-5b10-4630-970b-dcb4dedc719d
2438	4488fc9d-c634-4641-9507-4e9baaa94bee
6183	3e2bc231-5b10-4630-970b-dcb4dedc719d
4982	ed21c4cf-4d54-433f-a9fa-5301a3672791
4067	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
9109	3e2bc231-5b10-4630-970b-dcb4dedc719d
6282	ed21c4cf-4d54-433f-a9fa-5301a3672791
2572	3e2bc231-5b10-4630-970b-dcb4dedc719d
6455	4488fc9d-c634-4641-9507-4e9baaa94bee
4761	ed21c4cf-4d54-433f-a9fa-5301a3672791
3580	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b
2390	8c9df06e-f840-42ae-ad2f-e08af1ab330f
\.


--
-- Data for Name: post_ingredients; Type: TABLE DATA; Schema: public; Owner: doadmin
--

COPY public.post_ingredients ("postId", ingredient_id) FROM stdin;
1	1
1	2
1	3
1	4
2	5
2	6
2	7
2	8
2	1
2	4
3	9
3	10
3	1
4	11
4	12
4	3
4	13
5	9
5	3
5	7
5	6
5	4
6	14
6	15
6	13
6	16
7	1
7	2
7	3
7	4
8	5
8	6
8	7
8	8
8	1
8	4
9	9
9	10
9	1
10	17
10	18
10	19
10	20
10	21
11	17
11	18
11	19
11	20
11	21
11	22
12	17
12	18
12	19
12	20
12	21
12	22
12	23
13	24
13	25
13	26
14	5
14	6
14	19
15	27
15	28
15	1
16	9
16	29
16	30
16	31
17	32
17	6
17	19
17	26
18	29
18	33
18	34
19	29
19	35
19	36
20	37
20	38
20	36
21	39
21	29
21	38
21	40
5694	30
5694	23
4160	25
4160	28
4160	33
4160	22
4160	17
3057	15
3057	33
3057	23
3057	31
3057	34
4362	13
4362	36
4362	15
4362	34
9196	19
9196	5
7109	13
7109	39
7109	28
7109	16
4584	26
4584	17
4584	6
4584	4
4584	38
4584	40
1889	33
1889	7
1889	4
1889	23
1889	32
8171	11
8171	13
8171	40
8171	30
8171	24
1363	34
1363	5
1363	29
8791	5
5584	37
7786	15
7805	32
7805	27
7805	15
7805	25
4013	39
4013	5
4013	11
4013	29
6513	11
6513	7
6513	39
6513	31
6513	28
6513	40
6534	2
6534	29
5946	17
5946	15
5946	29
5946	30
7634	2
7634	39
7634	24
270	18
270	1
270	34
270	7
8016	19
8016	28
8016	30
1238	39
1238	3
6561	25
7795	24
7795	12
7795	9
7795	8
7795	6
7795	27
5511	3
7756	6
5118	19
5118	38
840	36
840	7
840	4
840	33
757	16
757	19
757	30
757	24
757	7
757	36
5780	23
5780	16
5780	10
5780	6
5780	2
5780	31
9310	9
6582	9
6582	16
6582	25
6582	5
5794	30
5794	3
5794	15
5794	25
4743	1
4743	37
4743	10
4743	27
7516	28
7516	19
7516	17
4414	37
4414	6
4414	40
4414	5
4414	13
4414	26
3179	9
3179	15
3179	13
8890	3
8890	26
2489	28
2489	8
2489	20
2489	17
2489	29
9617	30
9617	37
9671	31
9671	7
9671	27
9671	13
9671	33
6184	26
6184	37
788	38
788	29
788	24
788	15
7395	34
7395	4
7395	1
7395	20
7395	30
7395	17
1015	32
1015	19
1015	30
6105	1
5260	26
5260	25
7947	14
7947	7
7947	40
7947	18
7947	33
1723	20
1723	37
1723	33
6365	25
6365	15
6365	7
6165	29
6165	15
6165	13
6165	7
6165	3
6165	37
1582	15
5579	29
5579	15
5579	6
5579	5
5579	37
512	8
512	35
512	11
512	39
5777	2
5395	36
5395	23
5395	27
8707	24
8707	27
8707	15
3110	9
3110	8
9612	2
9612	35
9612	16
9612	30
9612	26
5416	18
5416	26
5416	37
3520	25
1359	39
1359	11
1359	8
1359	28
3555	37
3588	5
2551	25
2551	13
2551	14
2551	21
2551	5
718	15
718	3
718	13
718	29
4314	32
5891	24
5891	25
3248	35
3248	20
3865	24
3865	10
3865	29
3865	30
3865	23
987	9
987	5
6965	35
6965	16
6965	37
4360	36
4360	7
4360	33
968	8
968	2
968	37
968	16
968	20
8904	2
2545	17
2545	2
6771	27
6771	28
6771	7
9801	7
9801	39
9801	19
9801	5
9801	40
3564	25
5327	9
5327	21
5334	5
5334	36
5334	34
5334	23
7320	7
7320	17
709	28
793	37
793	32
793	11
793	29
7370	40
7370	39
7370	23
7370	34
7370	15
6734	8
6734	11
6734	5
6734	40
6734	15
6734	7
2018	35
2018	4
234	40
234	4
234	21
234	10
7827	1
7827	6
7827	23
2598	30
3476	19
3476	39
3476	10
3476	16
3476	21
3374	37
3374	12
3374	29
3374	7
3374	24
1107	25
1107	33
6839	9
5488	12
5488	24
5488	25
9938	28
499	35
499	29
499	26
499	3
499	38
5001	20
5001	25
5001	12
5001	5
5001	17
6114	10
6114	16
6114	11
4251	37
4767	26
2350	37
3480	40
5701	3
5701	33
5701	15
5701	22
5701	37
5701	40
3494	35
3494	28
3494	32
3494	6
3494	18
3494	29
410	34
410	19
6827	34
6827	7
6827	26
6827	17
6827	22
5740	31
5740	25
9379	8
9379	17
9379	40
9379	23
9379	2
9379	25
4428	19
4428	25
4428	29
4428	2
4428	23
9142	7
9142	37
9142	40
2216	29
2216	27
2216	32
2216	12
2216	6
2216	38
4395	40
4395	16
4395	29
4395	4
4395	15
4552	31
4552	30
4552	40
5679	12
5679	6
5679	9
9445	5
9445	36
4412	37
4412	34
3268	38
3598	19
3598	6
3598	22
3598	32
3598	37
3598	23
2552	7
2552	29
2552	17
5429	13
5429	9
5429	23
5429	29
5429	8
2771	7
2771	38
2771	33
2771	27
6903	10
5431	32
5431	18
5431	34
5431	7
5431	3
5431	17
7055	6
7055	31
7055	27
7055	1
7731	32
7731	1
7731	18
7731	22
7731	6
7731	4
5868	15
9481	4
9481	31
9481	15
9481	40
2704	22
9984	12
9984	35
9984	2
9984	27
9984	17
1761	36
1761	12
1761	6
1761	4
1761	17
5086	14
5086	38
5086	27
5086	34
5086	29
5086	7
797	29
797	36
797	14
797	1
797	18
797	30
8417	29
8417	4
8417	21
8417	25
2526	29
2526	31
2526	37
2526	28
2526	39
2526	12
1465	31
1465	17
1465	35
1465	24
1465	10
1465	18
6692	4
6692	1
6692	14
6692	7
8450	39
8450	32
8450	6
2202	27
2202	25
2202	7
8273	1
8273	3
8273	33
8273	34
8273	13
1930	4
1930	19
1930	29
1930	23
1930	24
7777	7
7777	14
8793	6
8793	11
8793	20
8793	15
8793	27
9000	19
1398	40
1398	37
1398	21
4377	9
7483	7
7483	22
7483	2
7483	14
8045	10
2330	22
2330	6
2330	21
2330	5
6927	1
6927	4
6927	25
6927	17
9557	39
9557	38
9557	3
931	19
931	17
931	7
931	28
931	15
931	3
991	30
991	34
991	14
991	23
668	26
668	15
668	17
668	32
668	29
1788	23
8456	20
7907	40
7907	35
7907	6
7907	27
6462	20
6462	33
6462	11
6462	2
6462	14
6462	5
1623	36
1623	6
1623	33
1623	13
1623	2
1623	30
4690	24
4690	32
4690	26
4690	19
446	36
446	32
446	10
4363	27
4363	38
4363	18
4363	6
3513	25
3513	8
9380	34
9380	5
1319	31
1319	16
1319	8
2576	38
2576	12
1285	34
1285	25
1285	31
1285	22
3738	11
6733	19
6733	26
6733	30
6733	32
6689	17
6689	9
6689	33
6689	11
6689	30
2326	34
2326	38
2326	5
3754	12
3754	25
3754	34
2171	3
2171	40
2171	28
2171	33
8755	23
8755	3
8755	9
8755	27
8755	37
4009	38
4009	6
4009	20
4009	25
5538	15
5538	30
5538	22
176	28
176	32
176	15
176	36
7431	7
7431	29
9047	6
4882	36
3929	34
3929	26
3929	39
3929	22
496	24
496	38
496	2
496	11
496	7
8674	10
8674	4
8674	19
8674	36
8674	1
8105	28
8105	34
8105	20
7234	39
7234	35
9460	20
9460	18
9645	26
9645	38
9645	34
9645	9
9645	23
9645	1
9930	7
9930	14
9930	6
3301	21
3301	33
3301	12
3301	7
2943	38
2943	13
2943	7
2943	12
7192	29
7192	33
3690	7
3690	4
3690	17
3690	26
3690	20
5427	21
5427	4
5427	7
5427	10
5427	1
3364	4
3364	14
3364	20
3364	2
6782	36
6782	32
9945	7
9945	10
9945	25
9945	11
5102	18
5102	2
5102	15
6309	24
6309	1
6309	20
7563	15
7563	2
7563	29
5226	6
5226	32
5226	11
5226	14
9660	37
9660	15
9660	31
9660	9
9660	34
3043	36
3043	19
9462	21
9285	14
9285	8
9285	23
9285	13
9285	38
9285	7
203	7
203	13
203	14
203	39
2151	1
2151	38
9393	9
9393	38
9393	3
9393	40
9393	4
9393	29
1564	36
1564	11
1564	8
1564	13
1564	22
1564	34
5845	21
5845	29
4653	12
7134	38
7134	23
7134	13
7134	9
4894	5
4894	24
4894	20
3818	11
3818	15
3818	21
3818	24
3818	22
4588	39
4588	10
4588	30
4588	34
4588	17
8316	13
8316	29
8316	24
8316	25
8316	18
3566	2
3566	20
3566	26
3566	14
3713	14
4639	22
4639	8
4639	17
4639	19
4639	2
1035	12
1035	27
1035	28
1035	5
1035	36
3607	2
3607	27
3607	33
3607	32
3607	7
4350	23
4350	13
4350	14
4350	2
4350	32
4080	34
2924	5
4505	19
4505	10
4505	11
9689	34
9689	7
9689	8
9689	13
8443	35
8443	23
8443	39
8443	7
8443	36
7638	5
7638	8
7638	6
7638	30
7638	29
7638	12
6012	24
6012	18
6012	14
5284	21
5284	13
5284	26
5284	7
5284	16
5284	33
4908	33
4908	31
4908	7
4908	17
8055	24
8055	29
8055	3
8055	19
8055	26
3671	33
3671	29
3671	25
3671	12
9913	11
9913	1
9913	13
9913	22
8680	6
8583	19
8583	4
8583	18
8583	29
8583	5
8583	25
5293	38
5293	28
5293	27
5293	33
4158	25
4158	7
4158	29
5353	38
2868	6
2868	11
2868	27
2868	33
4553	1
4553	8
4553	40
4553	13
4553	29
2822	27
2822	12
2822	33
2822	11
2822	29
9020	2
9020	27
346	39
346	27
346	8
4291	17
4291	16
106	23
106	25
287	24
287	40
287	15
287	16
9961	5
9961	12
9961	31
9961	7
9961	8
8679	7
8679	3
8679	29
8679	18
8679	25
2275	13
2275	16
2275	28
2275	17
2275	36
1116	2
4475	30
4475	13
4470	1
4470	12
3492	39
3492	26
3492	20
3492	37
3492	25
3492	17
2230	13
1223	31
1223	11
9527	34
9527	3
4543	14
4543	7
2477	4
1675	26
1675	38
1675	9
1675	40
9656	38
9656	26
6368	33
6368	16
6368	15
6368	30
2985	28
2985	10
2985	21
7310	3
7310	15
7310	39
7310	35
7310	32
6583	11
6583	19
6583	24
6583	40
5176	36
5176	14
5176	11
5176	21
2214	7
2214	15
2214	35
3526	3
8059	29
4286	37
4286	38
4286	10
4286	4
3499	23
3499	39
3499	37
3499	24
1425	29
6305	29
6305	38
6305	39
6305	37
6305	4
7385	31
2700	28
8950	35
8950	14
8950	18
8950	5
8950	10
8950	16
7999	5
5910	27
5910	18
5910	30
5910	38
1953	5
1953	33
1953	30
1953	40
8610	5
8610	29
8610	18
3907	11
3907	18
3618	5
3618	31
3618	21
3618	3
3618	15
5687	15
5687	37
5687	20
8107	4
8107	38
8107	16
6145	5
6145	32
6145	38
6145	28
6145	23
6145	14
8099	8
8099	5
8099	11
9574	40
9574	23
9574	25
9574	1
9207	18
9207	26
4387	27
4387	26
4387	24
4387	29
5731	22
5731	7
5731	11
5731	33
5731	24
2067	7
2067	27
6213	24
6213	8
9114	23
9114	1
9114	18
9114	16
9114	15
7477	19
7477	29
7477	25
9956	17
9956	4
9956	20
9956	6
9956	37
1860	16
1860	25
1860	20
1860	31
1860	3
1860	38
7241	9
7241	20
7241	22
7241	2
9133	36
9133	14
9133	10
5861	3
5861	15
5494	6
5494	10
6552	36
5496	11
5496	40
5496	19
9302	6
9302	7
9302	19
9302	2
9545	30
9545	24
9545	25
6476	7
8432	5
8432	30
8432	19
8432	9
8432	7
8432	32
6367	4
6367	16
6367	22
9653	32
9653	23
756	5
756	23
756	3
7202	29
7202	9
7202	30
9336	27
9336	7
9336	15
9336	6
2530	21
2530	16
2530	37
2530	15
8871	37
9267	10
9267	21
9267	5
9267	39
423	39
423	37
423	23
423	20
423	15
423	30
8248	21
8248	24
8248	37
8248	22
945	25
3208	28
3208	16
3208	17
461	2
461	28
461	35
5375	11
5375	21
5375	24
5375	25
5375	30
1685	4
1685	34
1685	7
1685	18
1685	20
2247	6
2247	13
2247	14
2247	12
600	17
600	5
600	15
600	26
600	32
600	36
8887	10
8887	9
8887	34
8887	18
8887	4
2916	9
2916	18
2916	32
2916	20
1014	33
1642	19
1642	12
7301	29
7301	26
7301	33
7301	13
7301	3
7301	2
8142	12
8142	1
8142	29
8142	25
3308	23
3308	21
3308	29
8054	37
830	32
830	1
830	17
830	7
8314	8
8839	20
8839	6
6002	12
5992	23
5992	2
5992	27
5992	10
5992	34
4617	25
4617	34
4617	3
4617	40
4280	30
4280	36
1290	12
1290	13
1290	20
1290	38
1290	6
1290	35
7776	12
7776	4
7776	13
7776	15
7776	29
1841	34
2748	13
2748	4
2748	26
2748	23
2748	35
4459	27
4459	13
4459	15
4539	21
4539	20
4539	29
7783	26
7783	10
2960	30
2960	23
2960	37
2960	35
95	5
95	6
95	16
95	23
5512	10
5512	14
5512	3
5512	18
5512	37
2101	29
2101	11
2101	10
2101	34
2101	15
6762	36
6762	24
7610	30
9966	7
9966	17
9966	34
9841	13
9841	37
9841	40
3502	15
3502	5
3502	29
689	9
689	29
689	16
689	22
689	17
4650	14
4650	23
4127	4
4127	2
4127	9
4127	24
4127	3
5950	10
5950	27
5950	8
7622	25
7622	4
7622	27
1454	39
1454	36
1454	22
3636	1
3636	32
3636	18
3636	39
7082	4
1534	11
1534	30
1534	9
1534	26
1534	14
6042	27
5702	37
5702	10
5702	7
5702	31
1996	14
1996	33
2540	19
2540	30
2540	17
7761	14
7761	19
7761	13
7761	3
2979	32
2979	17
6095	39
6095	15
6095	38
6095	29
6095	17
3038	10
3038	37
3840	13
3840	12
3840	21
3840	14
4887	40
4887	3
4887	2
4887	13
4887	26
3456	34
3456	35
3456	21
3456	38
3456	4
8987	23
8987	39
8987	5
8987	11
8987	8
9374	21
9374	32
595	35
595	26
595	24
595	11
595	7
595	1
9121	17
9121	10
5567	31
5567	3
5567	15
5567	18
5567	7
5567	12
6522	37
6522	6
6522	14
398	40
398	39
398	19
3284	36
3284	12
3284	24
3284	35
3132	20
8991	30
8991	14
3177	30
3177	36
3177	3
3177	38
8517	6
8517	24
3956	5
776	13
776	27
776	33
776	3
9901	32
9901	9
9901	23
9901	30
3626	39
3827	32
3827	38
3827	28
3827	14
3827	9
3827	5
6469	29
5850	7
662	38
662	5
8134	28
8134	25
6457	2
6457	9
6457	22
6457	11
6457	12
6457	18
5421	37
5421	7
5421	30
5421	34
5421	26
5421	13
3006	29
3006	17
3006	1
3006	3
3006	10
9357	35
3565	5
3565	6
3565	14
3565	15
9980	13
9325	40
9325	33
9325	11
9325	19
9325	12
9325	15
3643	25
3643	26
3643	12
3643	16
3643	8
1109	17
1109	30
8289	34
8289	14
8289	1
8289	20
9313	18
9313	12
9313	35
9085	3
9085	1
9085	2
9085	31
9085	4
3623	22
3623	27
997	40
41	14
41	37
41	36
41	38
5937	21
5937	1
5937	9
5937	8
5937	22
1316	14
1316	26
514	33
514	37
514	32
514	7
514	15
4587	29
7749	2
7749	14
7749	3
7749	11
7749	32
7488	33
7488	4
7488	21
7488	3
3906	32
3906	9
3906	29
3906	7
4510	9
4510	28
4510	1
6656	20
6656	17
6656	19
6656	8
4608	34
4608	16
4608	3
8425	26
8425	22
8425	2
8425	4
8425	14
3030	29
3030	35
3030	1
3030	20
3030	5
9840	32
9840	3
9840	10
9840	38
9840	26
9840	22
1247	38
1247	11
1247	35
1247	3
5816	8
5816	36
5816	33
5816	31
5816	34
5816	32
7213	14
7213	2
2548	33
2548	1
2548	29
2548	13
3841	39
3841	26
3841	20
3841	17
9502	19
9502	7
9502	40
9502	1
9502	33
9502	37
3145	3
3145	34
3145	23
3145	8
3145	4
2483	14
2483	35
2483	21
2483	39
8962	6
8962	39
8962	17
2255	8
4406	5
4406	29
4406	16
4406	36
4406	31
4406	12
2813	39
2813	8
8333	18
1670	6
1670	33
1074	34
3734	34
3734	17
3770	33
3770	22
3770	17
3770	28
3770	39
3770	13
572	18
572	29
572	26
4605	29
4605	18
4605	23
9390	39
9390	11
9390	33
9390	12
9390	1
9390	9
7628	13
7628	27
7628	29
7628	17
7628	6
6679	25
6679	31
6679	27
6679	11
6679	34
5268	5
4064	13
4064	26
4064	37
4064	3
4064	8
4064	40
7913	3
8057	9
8057	27
9401	15
9401	21
9401	29
9401	38
3352	7
3352	26
3352	17
5877	11
5877	7
5877	19
5877	35
5877	32
3013	4
3013	1
5153	25
5153	7
3441	13
3441	8
3441	29
3441	7
3441	26
172	28
172	21
172	38
8651	17
8651	21
8651	4
9810	29
9810	22
9810	33
9810	26
9810	3
9810	8
9437	40
9437	11
9437	12
9437	14
9437	34
3900	36
3900	17
3900	4
3900	28
5781	3
1152	29
1152	17
1152	15
1152	38
8148	18
8148	10
3888	32
3888	26
3888	34
3888	28
4760	31
4760	40
8738	33
8738	16
8738	6
8738	22
6396	13
1968	6
1968	18
1968	17
2522	2
5765	15
5765	39
5765	32
5765	21
5765	25
8498	23
9742	5
9742	32
9742	29
9742	18
9742	7
651	26
651	8
651	24
4390	33
4390	29
3260	35
3260	1
3260	8
8114	36
8114	28
8114	9
8114	13
4901	12
4901	7
7729	15
7729	38
6161	38
6161	12
6161	10
6161	18
3726	16
3726	24
3726	38
3726	40
3726	33
1804	16
6780	29
6780	10
6780	24
6780	15
4907	36
4554	11
4554	7
4554	16
4554	32
4554	36
3710	10
3710	17
3710	36
3710	5
7365	1
7365	26
7365	10
7508	11
7508	39
7508	16
7508	34
7508	21
7508	29
1940	13
1940	30
746	37
746	40
746	21
746	39
746	9
3465	8
3465	18
3465	22
3465	9
3465	27
447	8
8260	7
8260	9
8260	25
8260	40
8260	10
5879	22
5879	21
3930	17
3930	7
3930	29
3930	27
2952	34
8125	11
8125	39
8125	14
6228	37
6294	38
6294	32
6294	4
6294	29
6294	31
9733	36
9733	32
9733	10
9733	24
7330	18
9858	35
9858	14
9858	25
8025	26
8025	16
8025	8
8025	19
8025	32
5497	30
5497	17
5062	14
7148	33
377	29
377	37
377	14
377	25
1548	6
1548	14
1548	5
1548	37
1548	19
6723	7
6723	36
6723	27
6723	38
2990	14
2990	23
2990	26
740	40
740	16
7752	10
7752	13
1683	24
1683	22
1683	12
1683	30
1683	10
5415	11
3876	29
3876	25
6622	24
6622	33
6622	3
6622	1
6622	8
6622	39
8750	27
8750	23
1568	28
1568	2
1568	21
1568	5
1568	16
1481	8
1481	19
1481	16
1481	4
1481	18
6670	14
6670	21
6670	15
6907	22
5961	15
5961	16
5961	7
5961	4
8847	1
8847	32
8847	19
8953	40
8953	9
8953	24
8953	10
8635	31
8635	17
8635	15
8635	8
8635	20
7274	25
7274	21
7274	7
7274	29
7274	26
7274	12
3985	19
3000	10
2367	19
2367	13
8936	15
8936	27
8936	30
8936	19
8936	40
8936	5
8678	14
8678	33
8678	6
8678	7
8678	28
2345	29
2345	6
2345	13
2345	19
5312	15
5312	25
4225	5
4225	40
4225	1
9640	19
9640	39
9640	27
9640	9
4963	13
4963	34
4963	11
4963	37
4963	33
4963	29
4468	21
4468	32
4468	29
1309	23
7209	33
7209	21
7209	8
7209	34
7209	28
4567	31
4567	9
4567	11
9163	30
1131	23
1131	35
1131	32
1131	16
3469	6
3469	34
3469	32
3469	9
3469	26
8631	2
8631	6
8631	17
8631	8
2415	32
2415	29
2415	24
1078	16
1078	1
7885	21
7026	6
7026	8
7026	24
7026	33
7026	5
7218	24
7218	15
7218	8
9965	39
9965	32
3271	20
3271	37
3271	11
3271	29
9710	38
9710	9
8598	5
8598	23
8598	12
8598	7
7001	29
9200	29
9200	27
9200	25
9200	3
138	12
138	4
138	36
138	7
138	30
9749	1
645	2
645	18
645	16
645	23
645	21
645	22
173	29
173	31
554	20
2139	14
6813	18
6813	34
6813	6
6813	5
4604	9
4604	4
9861	10
9861	28
2301	14
2301	31
2301	36
2301	35
2301	4
2301	2
2224	19
2224	30
2224	26
2224	7
4230	38
3848	27
3848	15
3848	9
3848	39
3848	34
9974	13
9974	16
9974	10
9974	1
9926	24
7332	35
7332	26
7332	12
6055	7
6055	40
6055	38
6055	4
7010	15
7010	14
7010	31
7010	34
7993	21
7993	10
3541	11
3541	22
3541	24
3541	7
3541	3
3541	36
917	20
917	24
917	29
917	14
6076	7
6076	13
6076	24
6076	29
6076	27
6076	23
4858	28
4858	40
4858	3
4858	35
4858	34
1573	29
1573	34
1573	24
1573	26
1573	11
9871	35
9871	36
9871	37
9871	34
9871	9
4644	36
4644	12
4644	38
9914	26
5064	1
5064	21
5064	35
5064	7
8977	36
8977	14
8977	4
8977	18
8977	38
1120	37
8380	12
8380	19
9941	5
9941	31
9941	2
9941	26
9941	14
9824	16
9824	14
9824	8
9824	3
2835	2
8158	24
8158	31
8158	3
8158	10
8158	18
3986	7
3986	10
3986	2
3986	27
3986	3
8208	2
8208	18
8208	10
8208	5
8208	22
8208	15
7492	24
7492	37
7492	33
6981	33
6981	3
6981	27
6981	7
6981	14
6981	38
6223	17
2442	9
2442	8
2442	18
2442	32
2442	29
2601	40
2601	36
2601	33
2601	31
2601	30
583	11
7788	31
7788	12
7788	27
641	14
641	39
641	24
6745	9
6745	30
6745	2
6745	39
6855	5
6855	10
6855	19
6855	37
8145	13
8145	17
8145	20
4063	1
4063	5
5590	40
5721	11
5721	15
5721	28
5721	30
5721	5
6024	4
6024	36
6024	3
5951	40
5951	4
5951	35
5951	38
5951	9
5842	1
5842	29
5842	12
5842	15
2473	27
2473	2
9318	39
9318	17
9318	31
9318	33
9318	30
1507	29
1507	37
1507	11
1507	9
1507	3
8870	33
364	29
364	32
364	21
364	39
364	20
2379	11
2379	37
2379	13
5315	7
5315	38
5315	2
1237	16
1237	23
7085	35
7085	6
7085	29
7085	9
9113	33
9113	14
9113	13
1557	29
1557	24
8394	25
8394	19
127	9
127	2
5705	40
5705	16
5705	31
5705	29
6451	29
6451	7
6451	24
6451	40
5145	34
5145	36
5145	11
5145	6
5145	32
2810	38
2810	14
2810	18
3049	3
3049	18
3049	26
3049	29
9019	1
9019	3
9019	17
9019	10
9019	37
9019	8
268	26
268	13
268	35
268	28
7292	25
7292	3
7292	37
7292	26
7292	39
2080	36
866	10
9981	3
9981	2
9981	30
9981	15
9981	29
9981	18
8213	36
8213	16
8213	7
7296	2
7296	27
7296	24
218	13
1837	14
1837	10
1837	39
1837	19
1837	30
7027	14
7027	39
7027	23
7027	15
1110	9
5172	35
5172	11
5172	26
5172	10
8747	38
8747	33
7356	32
7356	18
7356	19
3400	7
3400	29
3400	30
3080	30
3080	16
3080	1
3080	6
1684	11
3508	21
3508	15
3508	31
3873	23
3873	17
3873	11
3873	19
3873	20
1910	30
1910	4
1910	10
1910	37
1910	29
1844	15
1844	1
9063	39
9063	21
2874	29
2874	5
2874	25
2874	21
2874	1
2874	19
6342	23
6342	25
6342	11
6342	38
6342	21
6342	13
9171	22
9171	12
9171	17
5772	28
5772	9
5772	10
5772	40
5772	1
6346	11
6346	35
6346	3
9697	36
9697	4
9697	9
9697	35
9697	39
9697	6
159	39
159	13
159	27
159	35
159	7
159	3
4719	4
4719	25
4719	12
4719	40
8561	9
9947	23
9947	22
9947	5
9947	34
3015	8
3015	30
3015	3
3015	4
9556	39
2556	2
2556	9
2556	15
3639	21
3639	11
3639	3
3639	16
3639	17
8578	24
8578	40
7587	9
7587	20
2420	37
2420	35
2420	8
2420	7
2420	34
6338	6
6338	23
5606	4
5606	12
5606	7
8044	30
8044	21
8044	7
4309	7
4309	19
4309	32
4309	35
4309	8
899	26
899	24
899	37
3402	20
2941	7
2941	36
2941	30
2941	23
6636	38
6636	39
6636	29
6636	35
6636	12
3461	25
3461	4
3461	33
3461	8
3461	13
1043	17
1043	19
1043	20
7917	13
7917	4
7917	30
7917	36
8100	2
8100	10
8100	31
8100	7
3829	21
6647	17
6647	25
6647	30
6647	20
6647	14
4730	19
1422	36
1422	35
78	6
78	32
78	39
4490	40
4490	28
4490	39
4490	22
5393	28
5393	5
5393	30
5393	29
5393	36
5393	25
5276	7
5276	6
5276	33
8003	15
5337	39
5337	13
5337	18
5337	11
5337	2
5337	40
3370	14
3370	36
9146	40
9146	32
149	20
149	4
149	19
149	30
7106	24
1793	24
3377	24
3377	7
3377	31
3377	27
3377	8
3944	26
3944	35
3944	24
3944	8
457	19
9788	1
6192	5
6192	36
6192	2
6192	33
6192	26
3430	27
3430	28
3430	29
3430	24
3430	23
3430	10
2438	27
6183	8
6183	20
6183	13
6183	5
6183	29
4982	12
4982	14
4982	35
4982	15
4067	30
9109	10
9109	18
9109	24
9109	21
9109	5
6282	24
6282	38
6282	9
2572	22
2572	32
2572	26
2572	29
6455	30
4761	32
3580	25
3580	13
3580	32
3580	36
2390	29
2390	32
2390	40
2390	22
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: doadmin
--

COPY public.posts (id, store, price, image, type, likes, "imageUrl", name) FROM stdin;
2	1	4.26	https://roll-club.kh.ua/wp-content/uploads/2021/04/4-mjasa-1.jpg.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1601924582970-9238bcb495d9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBUZXhhcyUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
3	1	7.43	https://roll-club.kh.ua/wp-content/uploads/2021/04/rostbif-v-tunce-1.jpg.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1528830984461-4d5c3cc1abf0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBIYXdhaWlhbiUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
4	2	3.25	https://316024.selcdn.ru/wiget/4d4c871a-107f-11e7-80df-d8d38565926f/49e75c35-6fff-4a0f-8d6a-959cf4721c74_Medium_.jpg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1508736793122-f516e3ba5569?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxPcmlnaW5hbCUyMGJ1cmdlciUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNjZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Original burger
5	2	2.63	https://316024.selcdn.ru/wiget/4d4c871a-107f-11e7-80df-d8d38565926f/93bce037-709e-41a0-9beb-ab3670663b40_Medium_.jpg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxDcmlzcHklMjBDaGlja2VuJTIwYnVyZ2VyJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNjA2N3ww&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
6	2	2.66	https://316024.selcdn.ru/wiget/4d4c871a-107f-11e7-80df-d8d38565926f/ba3a1ca2-2ec6-4cf4-a843-f7f0fc0f175a_Medium_.jpg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1542342656241-f23fedd6bafa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNjd8MA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
7	3	2.18	https://roll-club.kh.ua/wp-content/uploads/2019/03/kapricheza.jpg.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1513553404607-988bf2703777?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8UGl6emElMjBPY2VhbiUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2N3ww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
8	3	3.95	https://roll-club.kh.ua/wp-content/uploads/2015/09/4-syra.jpg.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBGbG9yaWRhJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
9	3	4.47	https://roll-club.kh.ua/wp-content/uploads/2014/08/ukrainskaja.jpg.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEl0YWxpYW5vJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
10	4	3.62	https://ninjasushi.com.ua/img/452.png	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1652637551796-1456f31be15c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGhpbGFkZWxwaGlhJTIwd2l0aCUyMHNhbG1vbiUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA2OHww&ixlib=rb-4.0.3&q=80&w=1080	Philadelphia with salmon
11	4	3.83	https://ninjasushi.com.ua/img/102-600x600.png	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607246749144-7bc0e401623c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxVbmFnaSUyMFBoaWxhZGVscGhpYSUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA2OHww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
12	4	5.91	https://roll-club.kh.ua/wp-content/uploads/2014/08/ukrainskaja.jpg.webp	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1562158147-f8d6fbcd76f8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8SGltYXdhcmklMjBzdXNoaXxlbnwwfHx8fDE3MjYwMDYwNjh8MA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
13	5	7.73	https://target.scene7.com/is/image/Target/GUEST_9066181d-e570-4eb1-b85d-1c8a547857fe?wid=1416&hei=1416&fmt=webp	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1533636040316-1a9598da3707?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8U3dlZGlzaCUyME1lYXRiYWxscyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
14	5	5.74	https://target.scene7.com/is/image/Target/GUEST_7c640617-96cd-4236-96f0-38a995828861?wid=1416&hei=1416&fmt=webp	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1511378156040-1259b5bcd0fb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxVbndyYXBwZWQlMjBCdXJyaXRvJTIwQm93bCUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
15	5	3.93	https://target.scene7.com/is/image/Target/GUEST_dd195641-5a34-4be1-9e14-c4632ee5942e?wid=1416&hei=1416&fmt=webp	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1707616954145-4483a30ca077?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8VG9ydGVsbGluaSUyMEJvd2xzJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA2MDY5fDA&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
16	6	6.52	https://i5.walmartimages.com/asr/64dc7c05-7d2c-4e29-854d-bada644f019e_1.f4de24032b1a5f48063903f488213f99.jpeg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1590677147861-622ec92a60f6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8Q2hpY2tlbiUyMFBvdCUyMFBpZSUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
17	6	7.51	https://i5.walmartimages.com/asr/94fb73ff-59ce-48c2-acd3-42bbb3c52e67.56499b84aa3d79c7a9c51f29da5c3626.png	173dd032-3d05-4927-b635-17bc8af6a6a0	\N	https://images.unsplash.com/photo-1599060095180-c2e7238e813c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8QmVlZiUyMCUyNiUyMEJlYW4lMjBHcmVlbiUyMENoaWxpJTIwQnVycml0b3MlMjBhcHBldGl6ZXJ8ZW58MHx8fHwxNzI2MDA2MDcwfDA&ixlib=rb-4.0.3&q=80&w=1080	Beef & Bean Green Chili Burritos
18	6	3.27	https://i5.walmartimages.com/asr/f490a06c-4ea2-41f5-9151-a05449e93e43.64a407ec5ca286d97dd37cdede9f51fc.jpeg	173dd032-3d05-4927-b635-17bc8af6a6a0	\N	https://images.unsplash.com/photo-1515779689357-8b2b205287d3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGVhbnV0JTIwQnV0dGVyJTIwJTI2JTIwR3JhcGUlMjBKZWxseSUyMFNhbmR3aWNoJTIwYXBwZXRpemVyfGVufDB8fHx8MTcyNjAwNjA3MHww&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter & Grape Jelly Sandwich
19	7	7.79	https://i5.walmartimages.com/asr/7be23ae2-0733-4fe1-a13c-13c1121db61a.37700bee4e0c25b6a3f93496ae17c7c7.jpeg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1649219025763-bb4a23fdf256?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxBbmdlbCUyMEZvb2QlMjBDYWtlJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwMDYwNzB8MA&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
20	7	2.59	https://i5.walmartimages.com/asr/7df68f47-78dc-4308-8a46-2ca7e1fa50e6.b2973bca56a71b9dc3e773ee08aeb1a6.jpeg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1499636136210-6f4ee915583e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8TmV3JTIwWW9yayUyMFN0eWxlJTIwQ2hlZXNlY2FrZSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDcwfDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
21	7	3.84	https://i5.walmartimages.com/asr/7bd145de-7975-4c04-842e-188a5a0be79d_2.57a9e072cd4d529d16ccd9125f6a035d.jpeg	7d985363-18f2-4e60-8bba-e53f3975b083	\N	https://images.unsplash.com/photo-1601000937859-3031d1be1caa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxTd2VldCUyMFBvdGF0byUyMFBpZSUyMHBhc3RyeXxlbnwwfHx8fDE3MjYwMDYwNzF8MA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
5694	5509	6.76	http://avnldwf.biz/LXcofhm.html	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8UGl6emElMjBPY2VhbiUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
4160	5509	2.11	https://wybuedp.info/fcfZAeJ	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1670338512239-556181fff224?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8UGl6emElMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Pizza
3057	5509	7.06	http://dgjufpg.edu/eemFSEo	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxXYWxsbWFydCUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
4362	5509	7.37	https://rprlsmt.net/OgZqXwT.css	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxTd2VldCUyMFBvdGF0byUyMFBpZSUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
9196	5509	4.78	http://www.vpehpwb.info/hVYITud	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1652637551796-1456f31be15c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGhpbGFkZWxwaGlhJTIwd2l0aCUyMHNhbG1vbiUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA2OHww&ixlib=rb-4.0.3&q=80&w=1080	Philadelphia with salmon
7109	5509	5.68	https://vumqcut.com/utvyiMk.js	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1605448303632-f46b1f293e35?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQZWFudXQlMjBCdXR0ZXIlMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3Mnww&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
4584	5509	3.95	https://yyjntsp.org/wCNPtOE.html	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1470259078422-826894b933aa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8TmV3JTIwWW9yayUyMFN0eWxlJTIwQ2hlZXNlY2FrZSUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA3Mnww&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
1889	5509	3.41	https://wjpyhjq.net/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8UGl6emElMjBJdGFsaWFubyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNzJ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
8171	5509	5.65	http://ypmvndl.com/tjqwBmN.svg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8UGl6emElMjBPY2VhbiUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
1363	5509	6.57	https://www.pvvtrnb.com/kNIdhrP	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMEhhd2FpaWFuJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwMDYwNzN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
8791	5509	3.76	https://www.ofcvekx.info/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1485921198582-a55119c97421?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8QW5nZWwlMjBGb29kJTIwQ2FrZSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNzN8MA&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
5584	5509	4.3	https://bovambo.org/vfrdTfH.svg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1533636040316-1a9598da3707?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8U3dlZGlzaCUyME1lYXRiYWxscyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
7786	5509	3.55	https://ziuqnbi.info/xhWlwlK.js	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxUb3J0ZWxsaW5pJTIwQm93bHMlMjBwaXp6YXxlbnwwfHx8fDE3MjYwMDYwNzN8MA&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
7805	5509	3.94	http://sidmuya.ru/yNQDnBP.jpg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxPcmlnaW5hbCUyMGJ1cmdlciUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDczfDA&ixlib=rb-4.0.3&q=80&w=1080	Original burger
4013	5509	6.79	https://guxzoyq.top/TrATukw.webp	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxQaXp6YSUyMEhhd2FpaWFuJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA2MDczfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
6513	5509	2.01	http://poojcoy.com/uJrGdHY.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1571997478779-2adcbbe9ab2f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxPcmlnaW5hbCUyMGJ1cmdlciUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3NHww&ixlib=rb-4.0.3&q=80&w=1080	Original burger
6534	5509	3.48	https://kyinhqm.com/slvICUx.webp	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1543255006-d6395b6f1171?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxTd2VldCUyMFBvdGF0byUyMFBpZSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDc0fDA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
5946	5509	2.09	http://mlkeitz.info/ElraShE.php	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1606152196365-d1ce5ea838b5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8UGl6emElMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwMDYwNzR8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza
7634	5509	4.54	http://jyjgiyl.biz/MEmyJqa.css	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEl0YWxpYW5vJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
270	5509	4.74	https://ehgqdgj.com/HFMdmJl.js	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1579751626657-72bc17010498?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8UGl6emElMjBGbG9yaWRhJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNjA3NHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
8016	5509	5.57	http://pwcppvg.biz/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8R3JhcGUlMjBKZWxseSUyMFNhbmR3aWNoJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDc1fDA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
1238	5509	6.38	https://rglqdth.com/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/31/RpgvvtYAQeqAIs1knERU_vegetables.jpg?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8QW5nZWwlMjBGb29kJTIwQ2FrZSUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3NXww&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
6561	5509	3.17	https://dervwir.info/jRHHtJT.js	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1571407970349-bc81e7e96d47?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8UGl6emElMjBQZXBwZXJvbmklMjB3aXRoJTIwdG9tYXRvZXMlMjBzdXNoaXxlbnwwfHx8fDE3MjYwMDYwNzV8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
7795	5509	3.07	https://paiximj.info/XBvrhva.css	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBUZXhhcyUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDc1fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
5511	5509	5.05	http://www.xcmtljs.edu/oQABnsV	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1533910534207-90f31029a78e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8U3dlZXQlMjBQb3RhdG8lMjBQaWUlMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwMDYwNzV8MA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
7756	5509	6.5	http://bfqsduh.top/uqtpWAS.jpg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
5118	5509	6.39	https://oipmunf.com/gINWWiy.svg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1525059696034-4967a8e1dca2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8VG9ydGVsbGluaSUyMEJvd2xzJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNjA3Nnww&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
840	5509	6.04	https://hurwucd.ru/vAhTggx	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1533910534207-90f31029a78e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8U3dlZXQlMjBQb3RhdG8lMjBQaWUlMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwMDYwNzV8MA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
757	5509	7.66	http://rdhhthh.edu/nZUBWuy.svg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1585238341267-1cfec2046a55?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNzZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza
5780	5509	4.43	https://iaqpklp.ru/jWiAPGL.webp	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxXYWxsbWFydCUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
9310	5509	5.07	https://ukooidl.edu/xZcNdKD.svg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEhhd2FpaWFuJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA2MDc3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
6582	5509	7.54	http://avurxhr.info/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1542342656241-f23fedd6bafa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNjd8MA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
5794	5509	6.42	https://vkrftsy.info/uieetgN.html	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1651870347822-d5cf1ce4e28f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8QmVhbiUyMEdyZWVuJTIwQ2hpbGklMjBCdXJyaXRvcyUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA3N3ww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
4743	5509	6.45	http://dpjtyup.org/YDsjtdu.html	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1518977877150-35db786d223a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8QmVhbiUyMEdyZWVuJTIwQ2hpbGklMjBCdXJyaXRvcyUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3N3ww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
7516	134	5.04	http://www.nthihvs.com/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1608220874995-aa3e5301c676?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGhpbGFkZWxwaGlhJTIwd2l0aCUyMHNhbG1vbiUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3N3ww&ixlib=rb-4.0.3&q=80&w=1080	Philadelphia with salmon
4414	134	6.15	https://hefdhtc.biz/pEpdLgY	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1533636040316-1a9598da3707?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8U3dlZGlzaCUyME1lYXRiYWxscyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
3179	134	7.9	https://bngkylr.edu/yaAmotY.php	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1495147466023-ac5c588e2e94?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxUb3J0ZWxsaW5pJTIwQm93bHMlMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3OHww&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
8890	134	7.86	http://brclplb.ru/nkUwGLg.html	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600628421055-4d30de868b8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGVhbnV0JTIwQnV0dGVyJTIwcGl6emF8ZW58MHx8fHwxNzI2MDg5NjEyfDA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
2489	134	3.4	http://garyvnl.edu/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1472393365320-db77a5abbecc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8UGl6emElMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MTJ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza
9617	134	5.1	https://hsgmlpb.info/vsKZksw	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1593504049359-74330189a345?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBUZXhhcyUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYxM3ww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
9671	134	6.47	http://opnunsn.ru/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
6184	134	6.99	http://naolfqj.biz/FaeOYjI.js	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1617957796155-72d8717ac882?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxCZWFuJTIwR3JlZW4lMjBDaGlsaSUyMEJ1cnJpdG9zJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjA4OTYxM3ww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
788	134	7.86	http://jynwtkb.net/jgcocDL.js	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1542342656241-f23fedd6bafa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNjd8MA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
7395	134	5.42	https://mhyioqn.top/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1550547660-d9450f859349?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQZWFudXQlMjBCdXR0ZXIlMjBidXJnZXJ8ZW58MHx8fHwxNzI2MDg5NjE0fDA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
1015	134	6.73	http://njbuiyx.edu/ErVHGtu.jpg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1531722596216-1fb4fbace9b7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxOZXclMjBZb3JrJTIwU3R5bGUlMjBDaGVlc2VjYWtlJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjE0fDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
6105	134	3.98	http://czswaej.net/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxXYWxsbWFydCUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTV8MA&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
5260	134	4.88	https://wcwqjri.ru/TPwRaYZ.jpg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxDcmlzcHklMjBDaGlja2VuJTIwYnVyZ2VyJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2MTV8MA&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
7947	134	5.02	https://ocldoir.edu/LCIXDBm.webp	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBIYXdhaWlhbiUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
1723	134	6.95	https://www.tnpxwog.top/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEl0YWxpYW5vJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
6365	134	6.74	http://jvlzrxj.top/KYTWIQB.js	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1631214524049-0ebbbe6d81aa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNnx8VW5hZ2klMjBQaGlsYWRlbHBoaWElMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwODk2MTZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
6165	134	6.39	https://lxeppjx.top/hgBWUDD.php	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607246749144-7bc0e401623c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxPcmlnaW5hbCUyMGJ1cmdlciUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYxNnww&ixlib=rb-4.0.3&q=80&w=1080	Original burger
1582	134	2.9	http://cxpitlq.top/lVPDiWK.html	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1533636040316-1a9598da3707?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8U3dlZGlzaCUyME1lYXRiYWxscyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
5579	134	3.83	http://vowpwmo.org/xEZOlEh.webp	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1628191013647-5640e14ded54?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8R3JhcGUlMjBKZWxseSUyMFNhbmR3aWNoJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjE3fDA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
512	134	2.54	https://nvbfvrk.biz/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1569761316261-9a8696fa2ca3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8VW5hZ2klMjBQaGlsYWRlbHBoaWElMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjA4OTYxN3ww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
5777	134	5.07	https://wcxgfoi.com/jqLwEXw.html	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxDcmlzcHklMjBDaGlja2VuJTIwYnVyZ2VyJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2MTV8MA&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
5395	134	4.09	http://qslqcbx.edu/AOBvQXV.webp	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyME9jZWFuJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjE4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
8707	134	3.75	http://lmupytp.edu/gjgeeHU.js	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1707616954145-4483a30ca077?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8VG9ydGVsbGluaSUyMEJvd2xzJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA2MDY5fDA&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
3110	134	5.21	http://vfxpeal.net/IiRrJAV.js	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEl0YWxpYW5vJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
9612	134	4.69	https://pecavda.com/NNthEbp	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1569761316261-9a8696fa2ca3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8VW5hZ2klMjBQaGlsYWRlbHBoaWElMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjA4OTYxN3ww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
5416	134	6.7	http://cglpsjt.info/jbJKPic.jpg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1485921198582-a55119c97421?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8QW5nZWwlMjBGb29kJTIwQ2FrZSUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjA4OTYxOHww&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
3520	134	3.83	https://kgaisfg.net/lceBCCV.css	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1513553404607-988bf2703777?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8UGl6emElMjBPY2VhbiUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2N3ww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
1359	134	5.33	https://vcdcina.net/WWMogbK	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxQaXp6YSUyMEhhd2FpaWFuJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA2MDczfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
3555	134	3.19	http://lipzdgi.info/turhCqb.php	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1568901346375-23c9450c58cd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxIaW1hd2FyaSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTh8MA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
3588	134	4.5	http://flrceka.info/IFdSlng.php	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8Q3Jpc3B5JTIwQ2hpY2tlbiUyMGJ1cmdlciUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYxOXww&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
2551	134	5.19	https://juqhelw.com/cSHRoTy	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1562158147-f8d6fbcd76f8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8SGltYXdhcmklMjBzdXNoaXxlbnwwfHx8fDE3MjYwMDYwNjh8MA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
718	134	3.04	http://dosbmgg.ru/yrWyGss.php	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1604186838309-c6715f0d3e6c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxXYWxsbWFydCUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjA4OTYxOXww&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
4314	134	7.25	http://asdztni.ru/ENRSfwy.svg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1605448303632-f46b1f293e35?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQZWFudXQlMjBCdXR0ZXIlMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3Mnww&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
5891	134	6.44	http://fihldgn.biz/JgPoEiX.js	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1484199383121-dfa3c30608cd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBGbG9yaWRhJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2MTl8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
3248	134	2.78	http://xmxhjzx.biz/hVOvkKL.jpg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1484199383121-dfa3c30608cd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBGbG9yaWRhJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2MTl8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
3865	134	4.62	http://wxatvxk.edu/SmWeXxB.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxDaGlja2VuJTIwUG90JTIwUGllJTIwcGl6emF8ZW58MHx8fHwxNzI2MDg5NjIwfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
987	134	3	https://dtwihpn.biz/SJrvQZp.webp	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxXYWxsbWFydCUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
6965	134	6.63	http://aooravc.top/qESRDxL	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxQaXp6YSUyMEZsb3JpZGElMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjB8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
4360	134	3.56	http://vwmcpgj.net/SfkghGC	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1571997478779-2adcbbe9ab2f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxPcmlnaW5hbCUyMGJ1cmdlciUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3NHww&ixlib=rb-4.0.3&q=80&w=1080	Original burger
968	134	6.66	http://neyqfbm.biz/GJtgkDm.html	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1533910534207-90f31029a78e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8U3dlZXQlMjBQb3RhdG8lMjBQaWUlMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwMDYwNzV8MA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
8904	134	7.92	https://mcwmvdd.biz/Larlpsu.php	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098731-5bf6416d2e8c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQZWFudXQlMjBCdXR0ZXIlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjF8MA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
2545	134	5.71	https://www.qxojrga.top/ecAgKlX	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1472393365320-db77a5abbecc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8UGl6emElMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MTJ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza
6771	134	6.79	http://hvvatfk.edu/pfXoUtg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBGbG9yaWRhJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
9801	134	2.97	https://nphxiub.info/HgmnPek.html	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjIxfDA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
3564	134	2.69	https://byxmnix.edu/xpLgVOx.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxUb3J0ZWxsaW5pJTIwQm93bHMlMjBwaXp6YXxlbnwwfHx8fDE3MjYwMDYwNzN8MA&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
5327	134	4.85	https://hsrlceg.org/IDRSMZr	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1576458088443-04a19bb13da6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8UGl6emElMjBJdGFsaWFubyUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjIyfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
5334	134	7.76	https://ozmrdjx.net/HUIrTdR.jpg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1529139574466-a303027c1d8b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8TmV3JTIwWW9yayUyMFN0eWxlJTIwQ2hlZXNlY2FrZSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MjJ8MA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
7320	134	7.2	https://wnkgsyz.top/fVexxWe.js	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBUZXhhcyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MjN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
709	134	7.8	http://dcxvqkq.ru/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1494314671902-399b18174975?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxTYWludCUyMEZyYW5rJTIwQ29mZmVlJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2MjN8MA&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
793	134	7.55	http://gufguwl.info/TkPotAI.html	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1533636040316-1a9598da3707?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8U3dlZGlzaCUyME1lYXRiYWxscyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
7370	134	5.4	https://vhjphda.biz/ljWoEqB.html	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1593504049359-74330189a345?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8UGhpbGFkZWxwaGlhJTIwd2l0aCUyMHNhbG1vbiUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyM3ww&ixlib=rb-4.0.3&q=80&w=1080	Philadelphia with salmon
6734	134	3.61	https://jmtmpca.org/wWMNhSX.svg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBIYXdhaWlhbiUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
2018	134	7.26	http://ueycxcb.org/iErdGUn.css	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBUZXhhcyUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDc1fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
234	134	3.04	http://fzwkpam.org/nNvLgno.jpg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1590677147861-622ec92a60f6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8Q2hpY2tlbiUyMFBvdCUyMFBpZSUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
7827	134	2.04	http://nhaypgh.edu/DCubMaZ	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBJdGFsaWFubyUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYyNHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
2598	134	7.85	https://mbcexlo.edu/ylLaVTI.html	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607246749144-7bc0e401623c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxVbmFnaSUyMFBoaWxhZGVscGhpYSUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA2OHww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
3476	134	3.91	https://dswrwgf.info/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1499636136210-6f4ee915583e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8TmV3JTIwWW9yayUyMFN0eWxlJTIwQ2hlZXNlY2FrZSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDcwfDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
3374	134	2.9	https://jxjubal.top/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1520072959219-c595dc870360?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8U3dlZGlzaCUyME1lYXRiYWxscyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MjR8MA&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
1107	134	6.16	http://www.litvafw.biz/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBJdGFsaWFubyUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYyNHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
6839	134	3.88	https://zuektye.biz/FYuNmHh.webp	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1604186838309-c6715f0d3e6c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxXYWxsbWFydCUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjA4OTYxOXww&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
5488	134	7.71	http://waxcdsp.net/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEl0YWxpYW5vJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
9938	134	4.07	http://www.wqptqae.edu/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1495774856032-8b90bbb32b32?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxTYWludCUyMEZyYW5rJTIwQ29mZmVlJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjI1fDA&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
499	134	2.82	http://www.sqpiosm.biz/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/31/RpgvvtYAQeqAIs1knERU_vegetables.jpg?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8QW5nZWwlMjBGb29kJTIwQ2FrZSUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3NXww&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
5001	134	3.45	https://godlocl.edu/JKAEJUv.jpg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607246749144-7bc0e401623c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxVbmFnaSUyMFBoaWxhZGVscGhpYSUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA2OHww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
6114	134	4.28	https://xjatnrl.net/TRuHaod.js	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBGbG9yaWRhJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
4251	134	3.09	https://osqgaff.com/OJkHpLG.css	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyME9jZWFuJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjE4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
4767	134	7.72	https://rejafqh.info/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1631214524049-0ebbbe6d81aa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNnx8VW5hZ2klMjBQaGlsYWRlbHBoaWElMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwODk2MTZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
2350	134	2.63	http://svuchjp.net/EhMjZgo.jpg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1651870347822-d5cf1ce4e28f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8QmVhbiUyMEdyZWVuJTIwQ2hpbGklMjBCdXJyaXRvcyUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA3N3ww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
3480	134	5.47	http://kcgbdib.net/GPeXPWq	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxXYWxsbWFydCUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyNXww&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
5701	134	7.38	http://www.forjfrx.top/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1533636040316-1a9598da3707?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8U3dlZGlzaCUyME1lYXRiYWxscyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
3494	134	6.13	https://uzwofxr.info/MjsDXWS	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1593504049359-74330189a345?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8UGhpbGFkZWxwaGlhJTIwd2l0aCUyMHNhbG1vbiUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyM3ww&ixlib=rb-4.0.3&q=80&w=1080	Philadelphia with salmon
410	134	7.41	http://lbwyvge.biz/JtNonfe.webp	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjI2fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
6827	134	7.74	https://www.bbnrxtm.biz/begyEKA	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxHcmFwZSUyMEplbGx5JTIwU2FuZHdpY2glMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjA4OTYyNnww&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
5740	134	6.53	http://www.zfewczi.edu/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1568901346375-23c9450c58cd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxIaW1hd2FyaSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTh8MA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
9379	134	2.57	http://nqalmse.info/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1606152196365-d1ce5ea838b5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8UGl6emElMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwMDYwNzR8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza
4428	134	2.74	http://rmciejp.top/ktxgGXH.html	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8R3JhcGUlMjBKZWxseSUyMFNhbmR3aWNoJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDc1fDA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
9142	3763	6.24	http://chnafhx.biz/XPVcZqw.jpg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1606152196365-d1ce5ea838b5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8UGl6emElMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwMDYwNzR8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza
2216	3763	5.29	http://uqkqvcv.edu/VHXwdmH.php	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1495147466023-ac5c588e2e94?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxUb3J0ZWxsaW5pJTIwQm93bHMlMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3OHww&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
4395	3763	7.17	https://lobusbx.top/ZRTZtDn.php	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1606152196365-d1ce5ea838b5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8UGl6emElMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwMDYwNzR8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza
4552	3763	4.82	http://nmywgrl.org/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1472393365320-db77a5abbecc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8UGl6emElMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MTJ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza
5679	3763	6.66	https://kumvish.top/GFXgxFp.js	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8U3dlZXQlMjBQb3RhdG8lMjBQaWUlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
9445	3763	3.75	http://zwqghze.info/YIvrcaR.css	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxDcmlzcHklMjBDaGlja2VuJTIwYnVyZ2VyJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2MTV8MA&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
4412	3763	4.49	https://jpfyhsf.top/qXLoOYJ.js	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBGbG9yaWRhJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
3268	3763	3.82	http://elldmkh.org/guWRgIA.webp	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1550547660-d9450f859349?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQZWFudXQlMjBCdXR0ZXIlMjBidXJnZXJ8ZW58MHx8fHwxNzI2MDg5NjE0fDA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
3598	3763	7.88	https://aetobys.org/WhfXAWb.css	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBUZXhhcyUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDc1fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
2552	3763	2.29	https://dgdfetj.ru/WOuyNhV.webp	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1562158147-f8d6fbcd76f8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8SGltYXdhcmklMjBzdXNoaXxlbnwwfHx8fDE3MjYwMDYwNjh8MA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
5429	3763	7.11	http://cxfniol.ru/UMWDmnE.svg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1601924582970-9238bcb495d9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxVbmFnaSUyMFBoaWxhZGVscGhpYSUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyN3ww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
2771	3763	7.89	https://bdcevhq.ru/EJGEZiG.webp	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxDcmlzcHklMjBDaGlja2VuJTIwYnVyZ2VyJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNjA2N3ww&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
6903	3763	3.04	http://joxndrs.ru/aPgkKlL.css	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1617957796155-72d8717ac882?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxCZWFuJTIwR3JlZW4lMjBDaGlsaSUyMEJ1cnJpdG9zJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjA4OTYxM3ww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
5431	3763	4.74	http://hmasvkp.edu/MvTRmBb.js	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1513553404607-988bf2703777?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8UGl6emElMjBPY2VhbiUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2N3ww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
7055	3763	6.93	https://www.xkcqcqs.net/WfFGUHe	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1606152196365-d1ce5ea838b5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8UGl6emElMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwMDYwNzR8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza
7731	3763	3.05	https://www.oabnhna.com/gemEmst	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1456324463128-7ff6903988d8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8U2FpbnQlMjBGcmFuayUyMENvZmZlZSUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyN3ww&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
5868	3763	2.85	http://www.xykpkdt.com/nfZlOtf	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
9481	3763	3.19	https://cpqnqan.ru/GgfxBvR.svg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxDaGlja2VuJTIwUG90JTIwUGllJTIwcGl6emF8ZW58MHx8fHwxNzI2MDg5NjIwfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
2704	3763	2.92	https://cwjgcvc.ru/KOqPcuA.jpg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxXYWxsbWFydCUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyNXww&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
9984	3763	5.31	http://www.cowmauo.org/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1543255006-d6395b6f1171?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxTd2VldCUyMFBvdGF0byUyMFBpZSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDc0fDA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
1761	3763	7.87	http://wkmaseh.org/WdiBYoE.js	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1571997478779-2adcbbe9ab2f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxPcmlnaW5hbCUyMGJ1cmdlciUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3NHww&ixlib=rb-4.0.3&q=80&w=1080	Original burger
5086	3763	6.98	https://www.gbdimee.org/dLODGKe	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBGbG9yaWRhJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
797	3763	6.13	https://zsernur.top/FOrkBAC.css	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8QmFjb24lMjBDaGVlc2UlMjBCdXJnZXIlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2Mjd8MA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
8417	3763	7.29	https://rknxckg.com/JIfWRKZ.css	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1508736793122-f516e3ba5569?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxPcmlnaW5hbCUyMGJ1cmdlciUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNjZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Original burger
2526	3763	3.33	https://zaewrsc.com/snKinfp.html	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxQaXp6YSUyMEhhd2FpaWFuJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA2MDczfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
1465	3763	5.35	https://www.hiuojxg.edu/sEvYhpx	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1571997478779-2adcbbe9ab2f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxPcmlnaW5hbCUyMGJ1cmdlciUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3NHww&ixlib=rb-4.0.3&q=80&w=1080	Original burger
6692	3763	6.18	http://ncdrgdi.edu/usJwweO.webp	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1605448303632-f46b1f293e35?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQZWFudXQlMjBCdXR0ZXIlMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3Mnww&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
8450	3763	3.33	https://gphbuln.edu/xFUAvPH	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1571407970349-bc81e7e96d47?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8UGl6emElMjBQZXBwZXJvbmklMjB3aXRoJTIwdG9tYXRvZXMlMjBzdXNoaXxlbnwwfHx8fDE3MjYwMDYwNzV8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
2202	4301	5.09	https://mwbhnnh.ru/oygUYCV.svg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxPcmlnaW5hbCUyMGJ1cmdlciUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDczfDA&ixlib=rb-4.0.3&q=80&w=1080	Original burger
8273	4301	2.32	https://acuyfxe.top/SsnDvyD.webp	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1601332069884-15a8149df78a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8UGhpbGFkZWxwaGlhJTIwd2l0aCUyMHNhbG1vbiUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2Mjh8MA&ixlib=rb-4.0.3&q=80&w=1080	Philadelphia with salmon
1930	4301	6.7	http://www.sdctwqe.ru/KwvObfC	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1520072959219-c595dc870360?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8VW53cmFwcGVkJTIwQnVycml0byUyMEJvd2wlMjBidXJnZXJ8ZW58MHx8fHwxNzI2MDg5NjI4fDA&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
7777	4301	3.37	http://sbcgsxd.ru/RcGMGXl.js	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEhhd2FpaWFuJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA2MDc3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
8793	4301	3.79	https://www.uqgtbdf.biz/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1611143669185-af224c5e3252?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxDcmlzcHklMjBDaGlja2VuJTIwYnVyZ2VyJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjI5fDA&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
9000	4301	3.4	http://qoptmsv.com/NMWkpeY.jpg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1513553404607-988bf2703777?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxQaXp6YSUyME9jZWFuJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2Mjl8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
1398	4301	2.01	http://mwqttnt.org/kCIhwXv.css	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1605448303632-f46b1f293e35?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQZWFudXQlMjBCdXR0ZXIlMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3Mnww&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
4377	4301	5.44	https://bmsgngx.org/MHngKNW.html	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098731-5bf6416d2e8c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQZWFudXQlMjBCdXR0ZXIlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjF8MA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
7483	4301	7.49	https://coginkt.top/eJcXHkn.css	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1571997478779-2adcbbe9ab2f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxOZXclMjBZb3JrJTIwU3R5bGUlMjBDaGVlc2VjYWtlJTIwcGl6emF8ZW58MHx8fHwxNzI2MDg5NjI5fDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
8045	4301	6.87	https://fdurdbr.com/lEySYiE.js	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1706954225234-fe9808ce3d72?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
2330	4301	5.8	https://wrtewad.com/vclwZeq.svg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1601924582970-9238bcb495d9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxVbmFnaSUyMFBoaWxhZGVscGhpYSUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyN3ww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
6927	4301	2.39	http://kvlhjji.edu/cwHJjOp.html	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1611143669185-af224c5e3252?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxDcmlzcHklMjBDaGlja2VuJTIwYnVyZ2VyJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjI5fDA&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
9557	4301	3.35	https://dtkwvow.com/ufwyrjO.js	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1476887334197-56adbf254e1a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxXYWxsbWFydCUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjMwfDA&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
931	4301	3.65	http://pcaoieh.net/bYfCSXI.webp	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1571407970349-bc81e7e96d47?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8UGl6emElMjBQZXBwZXJvbmklMjB3aXRoJTIwdG9tYXRvZXMlMjBzdXNoaXxlbnwwfHx8fDE3MjYwMDYwNzV8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
991	4301	3.77	https://hjdhoxv.org/vOjWELs	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1707616954145-4483a30ca077?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8VG9ydGVsbGluaSUyMEJvd2xzJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA2MDY5fDA&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
668	4301	2.63	http://jkgdtst.info/UbkXoEI.jpg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1617957796155-72d8717ac882?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxCZWFuJTIwR3JlZW4lMjBDaGlsaSUyMEJ1cnJpdG9zJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjA4OTYxM3ww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
1788	4301	5.83	https://www.ggylukq.net/sntgnkL	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1649219025763-bb4a23fdf256?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxBbmdlbCUyMEZvb2QlMjBDYWtlJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwMDYwNzB8MA&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
8456	4301	2.47	https://mygyhwp.edu/xTBYyKt.svg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1585238341267-1cfec2046a55?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNzZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza
7907	4301	4.18	http://ikobtyo.net/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1613371002402-208b2797ace3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8QmVhbiUyMEdyZWVuJTIwQ2hpbGklMjBCdXJyaXRvcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjA4OTYzMHww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
6462	4301	4.35	https://abrbbmr.com/lbVPqTh.css	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBGbG9yaWRhJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
1623	4301	6.99	http://qbhrltw.biz/sAigyRR.html	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1611143669185-af224c5e3252?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxDcmlzcHklMjBDaGlja2VuJTIwYnVyZ2VyJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjI5fDA&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
4690	4301	2.41	https://misrhcd.edu/yHPElGm.js	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1707616954145-4483a30ca077?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8VG9ydGVsbGluaSUyMEJvd2xzJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA2MDY5fDA&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
446	4301	4.59	http://qmxpufe.net/scQDbIm.svg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1569761316261-9a8696fa2ca3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8VW5hZ2klMjBQaGlsYWRlbHBoaWElMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjA4OTYxN3ww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
4363	4301	3.77	https://xubmdte.info/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1579751626657-72bc17010498?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8VW53cmFwcGVkJTIwQnVycml0byUyMEJvd2wlMjBwaXp6YXxlbnwwfHx8fDE3MjYwODk2MzF8MA&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
3513	4301	3.98	https://floebta.com/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBJdGFsaWFubyUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYyNHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
9380	4301	2.57	https://ampnihf.info/HOOsrRl.webp	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1508736793122-f516e3ba5569?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxPcmlnaW5hbCUyMGJ1cmdlciUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNjZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Original burger
1319	1679	7.61	https://mgsayta.com/rmyAwKu.html	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
2576	1679	6.81	http://muuvqce.net/hyMacxO.html	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1531722596216-1fb4fbace9b7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxOZXclMjBZb3JrJTIwU3R5bGUlMjBDaGVlc2VjYWtlJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjE0fDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
1285	1679	4.52	http://ufbffhx.ru/uugARjk.css	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1569761316261-9a8696fa2ca3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8VW5hZ2klMjBQaGlsYWRlbHBoaWElMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjA4OTYxN3ww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
3738	1679	5.84	https://ljfttdm.top/NjiAIpm.jpg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGl6emElMjBGbG9yaWRhJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
6733	1679	4.13	http://naufnvh.net/oqFBdYM.jpg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1571407970349-bc81e7e96d47?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8UGl6emElMjBQZXBwZXJvbmklMjB3aXRoJTIwdG9tYXRvZXMlMjBzdXNoaXxlbnwwfHx8fDE3MjYwMDYwNzV8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
6689	1679	6.22	http://www.locgcmu.com/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1617957796155-72d8717ac882?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxCZWFuJTIwR3JlZW4lMjBDaGlsaSUyMEJ1cnJpdG9zJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjA4OTYxM3ww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
2326	1679	5.32	http://pnjvniz.com/sbRSQBO	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBJdGFsaWFubyUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYyNHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
3754	1679	4.47	https://csvvmxk.com/UkiEBys.webp	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyME9jZWFuJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjE4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
2171	1679	4.91	https://ykxacwo.edu/sXWkeIy.html	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxXYWxsbWFydCUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyNXww&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
8755	1679	6.95	http://aqhyclj.info/jausRbT	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxXYWxsbWFydCUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyNXww&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
4009	1679	4.87	http://www.xujuldi.biz/PMuOUrb	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1529139574466-a303027c1d8b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8TmV3JTIwWW9yayUyMFN0eWxlJTIwQ2hlZXNlY2FrZSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MjJ8MA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
5538	1679	2.92	http://fptludj.net/gpHvosP.html	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
176	1679	2.58	http://rtnpeio.com/ekJUJTM.php	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxXYWxsbWFydCUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyNXww&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
7431	1679	6.41	http://unihdnl.net/yiDlHxd.css	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1456324463128-7ff6903988d8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8U2FpbnQlMjBGcmFuayUyMENvZmZlZSUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyN3ww&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
9047	1679	6.26	http://uiprqaq.org/uhcJwjt.jpg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098912-8b2b44fde4d6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxDaGlja2VuJTIwUG90JTIwUGllJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
4882	1679	6.89	http://akgvttx.org/wZZuZGe	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1571407970349-bc81e7e96d47?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8UGl6emElMjBQZXBwZXJvbmklMjB3aXRoJTIwdG9tYXRvZXMlMjBzdXNoaXxlbnwwfHx8fDE3MjYwMDYwNzV8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
3929	1679	7.5	https://www.vadaxby.ru/rHIXDDj	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8U3dlZXQlMjBQb3RhdG8lMjBQaWUlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
496	1679	7.1	http://jiltevw.ru/TjIkBaO.php	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1651870347822-d5cf1ce4e28f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8QmVhbiUyMEdyZWVuJTIwQ2hpbGklMjBCdXJyaXRvcyUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA3N3ww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
8674	1679	5.69	http://hhmtiwj.biz/TxtFipB.js	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8UGl6emElMjBJdGFsaWFubyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNzJ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
8105	1679	2.01	https://vthfckt.ru/AhfNVIA.webp	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8T3JpZ2luYWwlMjBidXJnZXIlMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwODk2MzJ8MA&ixlib=rb-4.0.3&q=80&w=1080	Original burger
7234	1679	6.81	http://alypxqh.org/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1579751626657-72bc17010498?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8UGl6emElMjBGbG9yaWRhJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNjA3NHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
9460	4867	5.85	http://toyxass.com/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600628421055-4d30de868b8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGVhbnV0JTIwQnV0dGVyJTIwcGl6emF8ZW58MHx8fHwxNzI2MDg5NjEyfDA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
9645	4867	6.96	https://ghjxnbg.ru/RhDGrRI.css	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1485921198582-a55119c97421?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8QW5nZWwlMjBGb29kJTIwQ2FrZSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNzN8MA&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
9930	4867	2.17	https://rqysfjp.ru/myrdmFn.php	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8UGl6emElMjBJdGFsaWFubyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNzJ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
3301	4867	4.97	https://akanouy.biz/eRTqbiv	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1508737027454-e6454ef45afd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxTd2VldCUyMFBvdGF0byUyMFBpZSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDU1NzR8MA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
2943	4867	3.26	http://cjozcqp.info/NEWRWdc.js	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1541544741938-0af808871cc0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNTU3NHww&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
7192	4867	5.37	https://ecxcwna.top/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1590452650110-3cf5fcb9c7b2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxQaXp6YSUyMHBpenphfGVufDB8fHx8MTcyNjAwNTU3NXww&ixlib=rb-4.0.3&q=80&w=1080	Pizza
3690	4867	7.16	http://zmwonom.ru/dIlTstq	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8QmFjb24lMjBDaGVlc2UlMjBCdXJnZXIlMjBwaXp6YXxlbnwwfHx8fDE3MjYwMDU1NzV8MA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
5427	4867	4.23	https://jhnyxkp.ru/wpyxYqW.php	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1542342656241-f23fedd6bafa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNjd8MA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
3364	4867	2.23	https://ytspctk.ru/ftKVUSA	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1653249288113-ed6e0db195a3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxCZWFuJTIwR3JlZW4lMjBDaGlsaSUyMEJ1cnJpdG9zJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwMDU1NzZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
6782	4867	4.3	https://lvuafoa.info/VkDMjci.jpg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1508737027454-e6454ef45afd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxTd2VldCUyMFBvdGF0byUyMFBpZSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDU1NzR8MA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
9945	4867	4.32	https://www.rxfkqhl.info/dKqhOCr	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxTd2VldCUyMFBvdGF0byUyMFBpZSUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
5102	4867	6.76	http://ynjbolh.top/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxDaGlja2VuJTIwUG90JTIwUGllJTIwcGl6emF8ZW58MHx8fHwxNzI2MDg5NjIwfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
6309	4867	4.91	https://vxmahuu.ru/UnVSPeO.jpg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098731-5bf6416d2e8c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQZWFudXQlMjBCdXR0ZXIlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjF8MA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
7563	4867	6.62	https://upixmex.edu/lCRSUgR.html	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjIxfDA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
5226	4867	6.7	https://svakzlx.top/uGpYZmd.webp	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8U3dlZXQlMjBQb3RhdG8lMjBQaWUlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
4505	4867	3.05	http://sbulkiw.biz/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8UGl6emElMjBJdGFsaWFubyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNzJ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
9660	4867	3.59	https://mxrqovt.com/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
3043	4867	6.89	http://edaicrl.com/KGjdTRl.js	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxQaXp6YSUyMEl0YWxpYW5vJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA1NTc2fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
9462	4867	5.21	https://www.moxujei.org/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1476887334197-56adbf254e1a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxXYWxsbWFydCUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjMwfDA&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
9285	4867	2.58	https://www.ssghygh.ru/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1590677147861-622ec92a60f6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8Q2hpY2tlbiUyMFBvdCUyMFBpZSUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
203	4867	4.76	https://rimrlsi.edu/DgRRLIU	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBGbG9yaWRhJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
2151	4867	2.69	https://uchvnqo.info/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
9393	4867	2.61	https://www.lfokwai.top/PiIUXso	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1670338512239-556181fff224?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8UGl6emElMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Pizza
1564	4867	4.64	http://www.doysmyw.ru/CuWMdtP	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1510297895683-0f27794412d5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGl6emElMjBPY2VhbiUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDU1NzZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
5845	4867	2.87	http://owjlmfm.net/JdLOgjy.svg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8T3JpZ2luYWwlMjBidXJnZXIlMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwODk2MzJ8MA&ixlib=rb-4.0.3&q=80&w=1080	Original burger
4653	4867	4.57	http://sqoxjxd.net/KPwaPYt.php	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1542342656241-f23fedd6bafa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNjd8MA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
7134	4867	2.46	https://xutovpg.info/dChKHhq.jpg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098731-5bf6416d2e8c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxTd2VkaXNoJTIwTWVhdGJhbGxzJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA1NTc3fDA&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
4894	4867	6.75	https://otawqnq.org/kvBWEFW.php	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1590677147861-622ec92a60f6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8Q2hpY2tlbiUyMFBvdCUyMFBpZSUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
3818	4867	2.71	https://phvwvvz.ru/wqpYwXH.jpg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1611143669185-af224c5e3252?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxHcmFwZSUyMEplbGx5JTIwU2FuZHdpY2glMjBzdXNoaXxlbnwwfHx8fDE3MjYwMDU1Nzd8MA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
4588	4867	4.98	https://oaxmika.ru/qCLnnOa.html	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxQaXp6YSUyMEZsb3JpZGElMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjB8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
8316	4867	2.94	http://www.vddknub.ru/wceDfKM	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxQaXp6YSUyMEl0YWxpYW5vJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA1NTc2fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
3566	4867	7.04	https://alqcchp.ru/IWCtJqM	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1513553404607-988bf2703777?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8UGl6emElMjBPY2VhbiUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2N3ww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
3713	4867	5.14	https://www.gulyzmw.ru/bqtOuMu	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBIYXdhaWlhbiUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
4639	4867	5.47	https://wqgoxfu.org/uqRHbcP.html	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1499636136210-6f4ee915583e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxIaW1hd2FyaSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA1NTc4fDA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
1035	4867	3.78	https://neizllu.net/pmKPtVq	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1670338512239-556181fff224?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8UGl6emElMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Pizza
3607	4867	7.17	http://qlzjlqi.top/pkEdYpd.svg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1494314671902-399b18174975?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxTYWludCUyMEZyYW5rJTIwQ29mZmVlJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2MjN8MA&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
4350	4867	6	http://szslmhw.net/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1499636136210-6f4ee915583e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxIaW1hd2FyaSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA1NTc4fDA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
4080	4867	7.81	http://kydzahm.top/WQnwMxK.svg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1571997478779-2adcbbe9ab2f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxPcmlnaW5hbCUyMGJ1cmdlciUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3NHww&ixlib=rb-4.0.3&q=80&w=1080	Original burger
2924	4867	4.66	https://wifaksq.top/btadedH	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1510297895683-0f27794412d5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGl6emElMjBPY2VhbiUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDU1NzZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
9689	4867	4.75	https://www.xjkpaxb.biz/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxDaGlja2VuJTIwUG90JTIwUGllJTIwcGl6emF8ZW58MHx8fHwxNzI2MDg5NjIwfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
8443	4867	4.95	http://keuvscb.org/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1579751626657-72bc17010498?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8UGl6emElMjBGbG9yaWRhJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNjA3NHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
7638	4867	6	http://qbbwsvx.net/LrPtVEF.js	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1495147466023-ac5c588e2e94?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxUb3J0ZWxsaW5pJTIwQm93bHMlMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3OHww&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
6012	4867	3.56	https://bltnmdh.edu/jlpuPiC.webp	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGl6emElMjBGbG9yaWRhJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
5284	4867	6.55	https://xhvknbt.info/RSpqaiO	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098731-5bf6416d2e8c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxTd2VkaXNoJTIwTWVhdGJhbGxzJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA1NTc3fDA&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
4908	4867	4.86	http://ruuvsog.net/bjKnInx.js	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1495147466023-ac5c588e2e94?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxUb3J0ZWxsaW5pJTIwQm93bHMlMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3OHww&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
8055	4867	2.51	http://mtdtttm.com/PcwqUhX.html	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1513553404607-988bf2703777?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8UGl6emElMjBPY2VhbiUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2N3ww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
3671	4867	4.44	http://xvheaia.edu/kLymXmv.webp	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBIYXdhaWlhbiUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
9913	4867	5.93	http://ceygezr.top/XTDSXbQ.webp	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1508736793122-f516e3ba5569?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxPcmlnaW5hbCUyMGJ1cmdlciUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNjZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Original burger
8680	4867	4.33	https://cuicctr.com/VtPZYre	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMEhhd2FpaWFuJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwMDYwNzN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
8583	4867	3.14	http://www.tdzzahp.info/aFKgVyL	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1562158147-f8d6fbcd76f8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8SGltYXdhcmklMjBzdXNoaXxlbnwwfHx8fDE3MjYwMDYwNjh8MA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
5293	4867	5.5	https://rqlqack.net/qZqRriO.js	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1531722596216-1fb4fbace9b7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxOZXclMjBZb3JrJTIwU3R5bGUlMjBDaGVlc2VjYWtlJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjE0fDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
4158	4867	4.85	http://tjtnwqo.net/QinmPoJ.webp	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBJdGFsaWFubyUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYyNHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
5353	4867	3.85	http://www.tpqrbky.edu/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1707616954145-4483a30ca077?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8VG9ydGVsbGluaSUyMEJvd2xzJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA2MDY5fDA&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
2868	4867	3.96	https://www.mfvkrby.top/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBGbG9yaWRhJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
4553	4867	2.54	http://rqyomfd.com/MoaALIo.jpg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1525059696034-4967a8e1dca2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8VG9ydGVsbGluaSUyMEJvd2xzJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNjA3Nnww&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
2822	4867	7.03	https://www.caybzvp.net/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxDcmlzcHklMjBDaGlja2VuJTIwYnVyZ2VyJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2MTV8MA&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
9020	4867	6.79	https://gnoiirw.top/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
346	4867	3.9	https://www.obuxfoo.edu/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1562158147-f8d6fbcd76f8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8SGltYXdhcmklMjBzdXNoaXxlbnwwfHx8fDE3MjYwMDYwNjh8MA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
4291	4867	7.74	https://spgvytp.org/SOyLhbc.js	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjIxfDA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
106	4867	7.01	http://www.tvemvff.info/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxTd2VkaXNoJTIwTWVhdGJhbGxzJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA1NTc4fDA&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
287	4867	2.43	https://mpjiesx.org/PrFJalj.php	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1499636136210-6f4ee915583e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8TmV3JTIwWW9yayUyMFN0eWxlJTIwQ2hlZXNlY2FrZSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDcwfDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
9961	4867	4.28	https://cjlbvfm.biz/kBiAmxd.webp	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1525059696034-4967a8e1dca2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8VG9ydGVsbGluaSUyMEJvd2xzJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNjA3Nnww&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
8679	4867	5.67	https://gprlwcr.edu/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1593504049359-74330189a345?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8UGhpbGFkZWxwaGlhJTIwd2l0aCUyMHNhbG1vbiUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyM3ww&ixlib=rb-4.0.3&q=80&w=1080	Philadelphia with salmon
2275	4867	4.14	http://www.gvoctfj.info/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxDaGlja2VuJTIwUG90JTIwUGllJTIwcGl6emF8ZW58MHx8fHwxNzI2MDg5NjIwfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
1116	4867	4.63	http://www.trqwwea.biz/YRUPBTW	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjIxfDA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
4475	4867	6.48	https://tkfwohw.org/SMnAFaV.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600628421055-4d30de868b8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGVhbnV0JTIwQnV0dGVyJTIwcGl6emF8ZW58MHx8fHwxNzI2MDg5NjEyfDA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
4470	4867	6.74	http://ogxfskv.biz/TqYxnbX.html	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098729-accb1f156620?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxVbndyYXBwZWQlMjBCdXJyaXRvJTIwQm93bCUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNTU3OHww&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
3492	4867	6.96	http://rtndzck.ru/AsfGTlu.html	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1613371002402-208b2797ace3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8QmVhbiUyMEdyZWVuJTIwQ2hpbGklMjBCdXJyaXRvcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjA4OTYzMHww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
2230	4867	7.38	http://ehuajhd.org/YZJMFEe.webp	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBUZXhhcyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MjN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
1223	4867	3.81	http://nonhopx.org/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1550547660-d9450f859349?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQZWFudXQlMjBCdXR0ZXIlMjBidXJnZXJ8ZW58MHx8fHwxNzI2MDg5NjE0fDA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
9527	4867	7.88	https://pgbvitg.net/qJoUnii.svg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1520072959219-c595dc870360?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8U3dlZGlzaCUyME1lYXRiYWxscyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MjR8MA&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
4543	4867	2.55	http://niflvyk.info/mKWOwgP.jpg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
2477	4867	5.86	http://hmwocaw.info/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1601924582970-9238bcb495d9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBUZXhhcyUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
1675	4867	4.55	http://ernvtjb.biz/elxrYkc.php	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBJdGFsaWFubyUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYyNHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
9656	4867	4.19	http://rwtaexm.info/GycMcyX.html	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBUZXhhcyUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDc1fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
6368	4867	6.24	http://www.cddshbv.org/rMgMjAc	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjI2fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
2985	4867	4.53	https://oaahjmg.edu/sXWEgsr.jpg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxDaGlja2VuJTIwUG90JTIwUGllJTIwcGl6emF8ZW58MHx8fHwxNzI2MDg5NjIwfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
7310	4867	5.78	https://xwfwyda.ru/wpSnGYC.js	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjIxfDA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
6583	4867	2.17	https://obsljhx.net/CSieTZC	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1606152196365-d1ce5ea838b5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8SGltYXdhcmklMjBwaXp6YXxlbnwwfHx8fDE3MjYwMDU1Nzh8MA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
5176	1352	2.54	https://kjhzhxj.info/ceaMbPH.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1518977877150-35db786d223a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8QmVhbiUyMEdyZWVuJTIwQ2hpbGklMjBCdXJyaXRvcyUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3N3ww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
2214	1352	6.52	http://www.wwygbry.net/buVpWMv	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxPcmlnaW5hbCUyMGJ1cmdlciUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDczfDA&ixlib=rb-4.0.3&q=80&w=1080	Original burger
3526	1352	6.22	http://mghgwnf.com/wTWBHkA.js	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1508737027454-e6454ef45afd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxDaGlja2VuJTIwUG90JTIwUGllJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNTU3OXww&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
8059	1352	2.24	http://hiculej.net/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1579751626657-72bc17010498?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8UGl6emElMjBGbG9yaWRhJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNjA3NHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
4286	1352	2.02	http://www.maqkeco.ru/JIRnNtC	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBJdGFsaWFubyUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYyNHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
3499	1352	6.11	https://jnhivvo.net/HETZskx	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1508737027454-e6454ef45afd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxDaGlja2VuJTIwUG90JTIwUGllJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNTU3OXww&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
1425	1352	5.36	http://www.iqngwcc.ru/QQWMwmi	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1628191013647-5640e14ded54?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8R3JhcGUlMjBKZWxseSUyMFNhbmR3aWNoJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjE3fDA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
6305	1352	2.63	http://wnduxld.top/RXAmcAG.webp	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjIxfDA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
7385	1352	4.25	https://aagdvpb.org/Auufytq	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1529139574466-a303027c1d8b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8TmV3JTIwWW9yayUyMFN0eWxlJTIwQ2hlZXNlY2FrZSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MjJ8MA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
2700	1352	5.2	http://vklioog.ru/YJRlScM.css	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1543255006-d6395b6f1171?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxTd2VldCUyMFBvdGF0byUyMFBpZSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDc0fDA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
8950	1352	4.31	http://ktsgmbs.info/xLCIDIA.svg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1518977877150-35db786d223a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8QmVhbiUyMEdyZWVuJTIwQ2hpbGklMjBCdXJyaXRvcyUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3N3ww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
7999	1352	7.01	https://ifioojc.top/YUWiFtd.js	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyME9jZWFuJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjE4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
5910	1352	5.35	https://wiwnqts.org/FfMiNRf.php	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1643078726430-fed25cc73ea3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxIaW1hd2FyaSUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNTU3OXww&ixlib=rb-4.0.3&q=80&w=1080	Himawari
1953	1352	7.96	http://www.defkrbb.info/ilxQMaD	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1579751626657-72bc17010498?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8UGl6emElMjBGbG9yaWRhJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNjA3NHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
8610	1352	2.25	https://xsameym.ru/EpjEbGN.html	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607246749144-7bc0e401623c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxPcmlnaW5hbCUyMGJ1cmdlciUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYxNnww&ixlib=rb-4.0.3&q=80&w=1080	Original burger
3907	1352	7.25	http://xtucqrc.biz/bUxOtKl.html	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxXYWxsbWFydCUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyNXww&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
3618	1352	7.4	http://egjuuhd.com/VkFgpRX.svg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8UGl6emElMjBJdGFsaWFubyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNzJ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
5687	1352	5.04	http://vbwmsoe.top/UtOPoVt.webp	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1603596310923-dbb12732f9c7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQZWFudXQlMjBCdXR0ZXIlMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwMDU1ODB8MA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
8107	1352	4.84	https://eurcamz.biz/mkoipxw.jpg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1617957796155-72d8717ac882?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxCZWFuJTIwR3JlZW4lMjBDaGlsaSUyMEJ1cnJpdG9zJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjA4OTYxM3ww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
6145	1352	6.68	http://qkwkrmx.top/RddrhBC.webp	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1472393365320-db77a5abbecc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8UGl6emElMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MTJ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza
8099	1352	6.4	https://ucpbndd.ru/JUuisRn.jpg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1506459225024-1428097a7e18?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8Q2hpY2tlbiUyMFBvdCUyMFBpZSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA1NTgwfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
9574	1352	2.54	https://npvnbxb.top/dNFiZOb.html	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1456324463128-7ff6903988d8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8U2FpbnQlMjBGcmFuayUyMENvZmZlZSUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyN3ww&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
9207	1352	5.72	https://awdiotv.net/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGl6emElMjBGbG9yaWRhJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
4387	1352	4.07	http://wddwjit.com/xgaCmZk.svg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1511378156040-1259b5bcd0fb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxVbndyYXBwZWQlMjBCdXJyaXRvJTIwQm93bCUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
5731	1352	7.52	https://uppxzdn.ru/vFCUIyB.jpg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1476887334197-56adbf254e1a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxXYWxsbWFydCUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjMwfDA&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
2067	1352	6.99	https://xjncnbk.edu/TfVAvHa.jpg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1631214524049-0ebbbe6d81aa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNnx8VW5hZ2klMjBQaGlsYWRlbHBoaWElMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwODk2MTZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
6213	1352	2.79	https://tddmlnd.com/mfPSGLn.php	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1706954225234-fe9808ce3d72?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
9114	1352	6.8	http://www.wouqkag.net/bOhlPqg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1495774856032-8b90bbb32b32?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxTYWludCUyMEZyYW5rJTIwQ29mZmVlJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjI1fDA&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
7477	1352	6.15	https://lroezjv.com/xRdsHOZ.css	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1643078726430-fed25cc73ea3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxIaW1hd2FyaSUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNTU3OXww&ixlib=rb-4.0.3&q=80&w=1080	Himawari
9956	1352	2.63	http://tmsnxut.info/GXiXkqc.php	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1525059696034-4967a8e1dca2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8VG9ydGVsbGluaSUyMEJvd2xzJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNjA3Nnww&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
1860	1352	6.92	https://jdbwvkq.info/JqjLQaZ.svg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
7241	1352	3.58	http://bwxadan.edu/SeErpss.css	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1508737027454-e6454ef45afd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxDaGlja2VuJTIwUG90JTIwUGllJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNTU3OXww&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
9133	1352	5.16	http://rckckon.info/HyeZvtj.php	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1605448303632-f46b1f293e35?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQZWFudXQlMjBCdXR0ZXIlMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3Mnww&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
5861	1352	7.77	http://www.mtdvcyi.net/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1495774856032-8b90bbb32b32?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxTYWludCUyMEZyYW5rJTIwQ29mZmVlJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjI1fDA&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
5494	1352	3.95	http://ddyjxjx.biz/Ihpmofl.html	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098731-5bf6416d2e8c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQZWFudXQlMjBCdXR0ZXIlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjF8MA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
6552	1352	6.89	http://hfojjqv.com/oorvdWY.php	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8Q3Jpc3B5JTIwQ2hpY2tlbiUyMGJ1cmdlciUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYxOXww&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
5496	1352	3.82	https://nhknhmz.top/ohuTWyC.html	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxTd2VkaXNoJTIwTWVhdGJhbGxzJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA1NTc4fDA&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
9302	1352	5.59	https://nhlgldo.org/tkmtiLS.jpg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1543255006-d6395b6f1171?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxTd2VldCUyMFBvdGF0byUyMFBpZSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDc0fDA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
9545	1352	6.69	https://lpwyukg.edu/KNivCfY.html	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098729-accb1f156620?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxVbndyYXBwZWQlMjBCdXJyaXRvJTIwQm93bCUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNTU3OHww&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
6476	1352	3.38	https://opykmsp.net/RaimhyC.webp	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098731-5bf6416d2e8c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxTd2VkaXNoJTIwTWVhdGJhbGxzJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA1NTc3fDA&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
8432	1352	7.42	http://xxsgquh.ru/sfbMsrO.html	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxXYWxsbWFydCUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTV8MA&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
6367	1352	7.68	https://www.iovtqnr.info/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1495774856032-8b90bbb32b32?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxTYWludCUyMEZyYW5rJTIwQ29mZmVlJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjI1fDA&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
9653	1352	6.78	https://mfmcdge.edu/KLJBTRp.svg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBGbG9yaWRhJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
756	1352	4.64	https://vakgtfm.com/omrgUxX.webp	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1628191013647-5640e14ded54?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8R3JhcGUlMjBKZWxseSUyMFNhbmR3aWNoJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjE3fDA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
7202	1352	6.25	https://xclajyn.info/mZhDaqn.svg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEl0YWxpYW5vJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
9336	1352	4.99	http://xseekfv.org/wAIpghV	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxXYWxsbWFydCUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyNXww&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
2530	1352	3.81	https://rgupzja.top/oNawKor.html	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1651870347822-d5cf1ce4e28f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8QmVhbiUyMEdyZWVuJTIwQ2hpbGklMjBCdXJyaXRvcyUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA3N3ww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
8871	1352	6.87	https://cycljhr.edu/havVdXp.svg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxXYWxsbWFydCUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
9267	1352	6.35	http://tijnlmx.net/caalJhP.svg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1617957796155-72d8717ac882?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxCZWFuJTIwR3JlZW4lMjBDaGlsaSUyMEJ1cnJpdG9zJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjA4OTYxM3ww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
423	1352	2.94	http://pksslrv.top/DwiahIl.jpg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1652637551796-1456f31be15c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGhpbGFkZWxwaGlhJTIwd2l0aCUyMHNhbG1vbiUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA2OHww&ixlib=rb-4.0.3&q=80&w=1080	Philadelphia with salmon
8248	1352	4.52	https://mzwqdde.ru/pdSQSII.jpg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1525059696034-4967a8e1dca2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8VG9ydGVsbGluaSUyMEJvd2xzJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNjA3Nnww&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
945	1352	5.21	http://zscmnub.biz/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMEhhd2FpaWFuJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwMDYwNzN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
3208	1352	7.93	https://qtgqqwb.info/rUCqskD.webp	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1590677147861-622ec92a60f6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8Q2hpY2tlbiUyMFBvdCUyMFBpZSUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
461	1352	5.12	http://usohbqi.edu/iifSoRW.jpg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBUZXhhcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNTU4MHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
5375	1352	7.64	https://www.zltauit.net/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8UGl6emElMjBJdGFsaWFubyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNzJ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
1685	1352	2.19	http://stxanwl.com/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBJdGFsaWFubyUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYyNHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
2247	1352	7.5	http://yexmsnb.edu/ntSlEKj.svg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxTd2VldCUyMFBvdGF0byUyMFBpZSUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
600	1352	2.12	http://www.xuqsjvu.ru/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1513553404607-988bf2703777?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxQaXp6YSUyME9jZWFuJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2Mjl8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
8887	1352	6.91	https://oonqaew.biz/ePPcsMg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1533910534207-90f31029a78e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8U3dlZXQlMjBQb3RhdG8lMjBQaWUlMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwMDYwNzV8MA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
2916	1352	7.18	https://rnjnnjo.net/ystkkAZ.svg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1569761316261-9a8696fa2ca3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8VW5hZ2klMjBQaGlsYWRlbHBoaWElMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjA4OTYxN3ww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
1014	1352	3.63	https://www.xodokrd.ru/qVjptYZ	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/31/RpgvvtYAQeqAIs1knERU_vegetables.jpg?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8QW5nZWwlMjBGb29kJTIwQ2FrZSUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNTU4MXww&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
1642	1352	6.3	https://www.mymepsx.biz/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607246749144-7bc0e401623c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxPcmlnaW5hbCUyMGJ1cmdlciUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYxNnww&ixlib=rb-4.0.3&q=80&w=1080	Original burger
7301	1352	3.63	https://uoekxph.com/MdoGAdq	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxXYWxsbWFydCUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTV8MA&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
8142	1352	4.1	https://lnxgfcl.com/mLsVIpk.css	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxHcmFwZSUyMEplbGx5JTIwU2FuZHdpY2glMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjA4OTYyNnww&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
3308	1352	6.45	https://ufltgws.org/IATjhxy.php	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEl0YWxpYW5vJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
8054	1352	2.9	http://qfltvlv.biz/mxZNtJW.php	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1506459225024-1428097a7e18?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8Q2hpY2tlbiUyMFBvdCUyMFBpZSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA1NTgwfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
830	1352	5.69	https://owfyesx.edu/fBMRrSs.html	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxDcmlzcHklMjBDaGlja2VuJTIwYnVyZ2VyJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNjA2N3ww&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
8314	1352	5.78	http://www.fhuuyol.top/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1579751626657-72bc17010498?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8VW53cmFwcGVkJTIwQnVycml0byUyMEJvd2wlMjBwaXp6YXxlbnwwfHx8fDE3MjYwODk2MzF8MA&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
8839	1352	5	https://qmutnxr.biz/dlWUOrh.jpg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1652637551796-1456f31be15c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGhpbGFkZWxwaGlhJTIwd2l0aCUyMHNhbG1vbiUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA2OHww&ixlib=rb-4.0.3&q=80&w=1080	Philadelphia with salmon
6002	1352	4.11	https://www.eboyjaa.edu/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1649219025763-bb4a23fdf256?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxBbmdlbCUyMEZvb2QlMjBDYWtlJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwMDYwNzB8MA&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
5992	1352	4.11	https://vyqansi.top/OWIEtZH.svg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1590452650110-3cf5fcb9c7b2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxQaXp6YSUyMHBpenphfGVufDB8fHx8MTcyNjAwNTU3NXww&ixlib=rb-4.0.3&q=80&w=1080	Pizza
4617	1352	3.23	http://dntlpfg.com/PRksjel	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1631214499883-47ef353c0372?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8VW5hZ2klMjBQaGlsYWRlbHBoaWElMjBidXJnZXJ8ZW58MHx8fHwxNzI2MDA1NTgxfDA&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
4280	1352	7.76	http://www.goolsmu.com/AxiTtwX	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1476887334197-56adbf254e1a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxXYWxsbWFydCUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjMwfDA&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
1290	1352	3.41	https://www.ftvlwuf.biz/CEcQjMx	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8R3JhcGUlMjBKZWxseSUyMFNhbmR3aWNoJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDc1fDA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
7776	1352	3.65	https://lfwghvi.biz/XIqgAXH.jpg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098731-5bf6416d2e8c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQZWFudXQlMjBCdXR0ZXIlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjF8MA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
1841	1352	7.06	https://picuvro.ru/cJxDxPF.js	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
2748	1352	2.59	https://gmfijpa.top/xwZcDji.svg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/31/RpgvvtYAQeqAIs1knERU_vegetables.jpg?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8QW5nZWwlMjBGb29kJTIwQ2FrZSUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNTU4MXww&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
4459	1352	3.86	http://qgrczsr.info/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEhhd2FpaWFuJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA2MDc3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
4539	1352	3.68	http://ecgrprr.org/kRfWVXu.webp	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607246749144-7bc0e401623c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxPcmlnaW5hbCUyMGJ1cmdlciUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYxNnww&ixlib=rb-4.0.3&q=80&w=1080	Original burger
7783	1352	6.73	http://ukuamzb.top/nfTfxfP.css	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1485921198582-a55119c97421?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8QW5nZWwlMjBGb29kJTIwQ2FrZSUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjA4OTYxOHww&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
2960	1352	3.45	http://asfkbif.com/mMURhqc.html	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1476887334197-56adbf254e1a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxXYWxsbWFydCUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjMwfDA&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
95	1352	4.46	https://diqtojo.biz/MOcuRVG.php	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1513553404607-988bf2703777?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8UGl6emElMjBPY2VhbiUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2N3ww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
5512	1352	5.51	https://dzghihc.biz/NHjnHPE.php	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8U3dlZXQlMjBQb3RhdG8lMjBQaWUlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
2101	1352	3.35	https://www.wtibjog.top/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1605448303632-f46b1f293e35?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQZWFudXQlMjBCdXR0ZXIlMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3Mnww&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
6762	1352	3.94	http://zmyiklx.net/ImffUUQ.html	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1670338512239-556181fff224?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8UGl6emElMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Pizza
7610	1352	4.09	https://fbrnfqx.biz/AWrJOXB.html	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1628191013647-5640e14ded54?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8R3JhcGUlMjBKZWxseSUyMFNhbmR3aWNoJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjE3fDA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
9966	1352	6.52	https://www.xjihotw.top/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098729-accb1f156620?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxVbndyYXBwZWQlMjBCdXJyaXRvJTIwQm93bCUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNTU3OHww&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
9841	1352	4.66	https://hsildos.info/SajEhnf.js	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEhhd2FpaWFuJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA2MDc3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
3502	1352	5.92	https://xkpoifg.ru/bREEgcb.js	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1533636040316-1a9598da3707?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8U3dlZGlzaCUyME1lYXRiYWxscyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
689	1352	6.26	http://kqkxhda.org/oARyCKa.html	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1631214524049-0ebbbe6d81aa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNnx8VW5hZ2klMjBQaGlsYWRlbHBoaWElMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwODk2MTZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
4650	1352	2.3	http://xmlotan.info/CfxrrUw.html	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1499636136210-6f4ee915583e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxIaW1hd2FyaSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA1NTc4fDA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
4127	1352	2.32	http://aaforhg.top/bjZFDUI.css	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1508736793122-f516e3ba5569?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxPcmlnaW5hbCUyMGJ1cmdlciUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNjZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Original burger
5950	1352	4.96	http://www.xfybavu.edu/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBUZXhhcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNTU4MHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
7622	1352	4.15	https://hubuync.net/dPxfubJ.js	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1542342656241-f23fedd6bafa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNjd8MA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
1454	1352	6.68	http://www.lqossfi.org/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1513553404607-988bf2703777?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8UGl6emElMjBPY2VhbiUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2N3ww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
3636	1103	4.45	http://fbrrjbu.org/wrdqcoU.css	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBGbG9yaWRhJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
7082	1103	3.63	http://www.bnhkwpf.net/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1613371002402-208b2797ace3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8QmVhbiUyMEdyZWVuJTIwQ2hpbGklMjBCdXJyaXRvcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjA4OTYzMHww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
1534	1103	6.11	https://cwaonqs.net/jrOIohl	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBUZXhhcyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MjN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
6042	1103	3.08	https://ysbmgya.info/KjylDjV.jpg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1707616954145-4483a30ca077?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8VG9ydGVsbGluaSUyMEJvd2xzJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA2MDY5fDA&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
5702	1103	6.82	https://xbmagfv.net/VqoVbQh.php	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1472393365320-db77a5abbecc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8UGl6emElMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MTJ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza
1996	1103	6.5	http://tphffga.ru/FEGnjmF.svg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxQaXp6YSUyMEl0YWxpYW5vJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA1NTc2fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
2540	1103	4.06	https://www.zmngfxh.info/sPZlWGK	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyME9jZWFuJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjE4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
7761	1103	6.06	http://lhgpueo.org/peNPjTX.js	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1468218620578-e8d78dcda7b1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxVbndyYXBwZWQlMjBCdXJyaXRvJTIwQm93bCUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA1NTgxfDA&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
2979	1103	2.5	https://fwotnqy.top/JMJELtk.svg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1617957796155-72d8717ac882?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxCZWFuJTIwR3JlZW4lMjBDaGlsaSUyMEJ1cnJpdG9zJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjA4OTYxM3ww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
6095	1103	2.89	http://jxsxsng.ru/dHDVuXr	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBIYXdhaWlhbiUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
3038	1103	6.72	http://krtoucn.org/DcgBjem.css	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1513553404607-988bf2703777?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxQaXp6YSUyME9jZWFuJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2Mjl8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
3840	1103	7.49	https://srbacbw.info/VFMjlsq	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1485921198582-a55119c97421?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8QW5nZWwlMjBGb29kJTIwQ2FrZSUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjA4OTYxOHww&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
4887	1103	5.51	https://www.swnocgi.com/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBGbG9yaWRhJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
3456	1103	4.68	http://www.stxvpdo.info/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1476887334197-56adbf254e1a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxXYWxsbWFydCUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjMwfDA&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
8987	1103	2.66	http://anewowq.biz/DlpudIT.php	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxQaXp6YSUyMEhhd2FpaWFuJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA2MDczfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
9374	1103	4.48	http://fwrwakm.ru/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
595	1103	6	http://rssalbb.ru/xWEZEHt.svg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1506459225024-1428097a7e18?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8Q2hpY2tlbiUyMFBvdCUyMFBpZSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA1NTgwfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
9121	1103	2.54	https://ogwmpud.org/IuDWoRU.js	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1593504049359-74330189a345?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBUZXhhcyUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYxM3ww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
5567	1103	4.74	http://www.nvuhnsh.top/JyNJYvv	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1606152196365-d1ce5ea838b5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8SGltYXdhcmklMjBwaXp6YXxlbnwwfHx8fDE3MjYwMDU1Nzh8MA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
6522	1103	4.29	http://yemqaih.info/MlWTvpq.svg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1653249288113-ed6e0db195a3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxCZWFuJTIwR3JlZW4lMjBDaGlsaSUyMEJ1cnJpdG9zJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwMDU1NzZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
398	1103	3.4	http://wyegjud.net/QhMjhmG.php	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1601924582970-9238bcb495d9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxVbmFnaSUyMFBoaWxhZGVscGhpYSUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyN3ww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
3284	1103	7.56	https://ekbeytt.org/eTgifbB.svg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjI2fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
3132	1103	7.73	http://ojumkty.top/jKWBQSW.php	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxTd2VkaXNoJTIwTWVhdGJhbGxzJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA1NTc4fDA&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
8991	1103	5.54	http://lusvajs.ru/HavTfJA.js	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1513553404607-988bf2703777?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8UGl6emElMjBPY2VhbiUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2N3ww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
3177	1103	7.04	http://buwzqcw.net/WbircGE.jpg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyME9jZWFuJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjE4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
8517	1103	3.74	https://exshbdf.edu/mUhNIiq.js	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1571997478779-2adcbbe9ab2f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxOZXclMjBZb3JrJTIwU3R5bGUlMjBDaGVlc2VjYWtlJTIwcGl6emF8ZW58MHx8fHwxNzI2MDg5NjI5fDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
3956	1103	2.07	http://lyyglow.top/gDHpsrr.php	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxDcmlzcHklMjBDaGlja2VuJTIwYnVyZ2VyJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2MTV8MA&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
776	1103	5.32	http://yjvarup.edu/CGhQHkM.php	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyME9jZWFuJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjE4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
9901	1103	4.97	https://owqtway.com/iQuyIld.css	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1513553404607-988bf2703777?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxQaXp6YSUyME9jZWFuJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2Mjl8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
3626	1103	3.47	https://www.uwhavbl.com/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1576458088443-04a19bb13da6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8UGl6emElMjBJdGFsaWFubyUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjIyfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
3827	1103	6.04	https://qpseyaz.org/RpLyufC.js	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEhhd2FpaWFuJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA2MDc3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
6469	1103	2.13	https://btvfdpy.edu/tEeTWWE.php	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607246749144-7bc0e401623c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxVbmFnaSUyMFBoaWxhZGVscGhpYSUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA2OHww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
5850	1103	6.39	https://kuuahte.ru/OlmmdNC.css	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1521401292936-0a2129a30b1c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxTYWludCUyMEZyYW5rJTIwQ29mZmVlJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA1NTgyfDA&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
662	1103	2.24	https://www.qhohphj.org/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1485921198582-a55119c97421?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8QW5nZWwlMjBGb29kJTIwQ2FrZSUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjA4OTYxOHww&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
8134	1103	3.46	http://www.ayonmnb.com/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxHcmFwZSUyMEplbGx5JTIwU2FuZHdpY2glMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjA4OTYyNnww&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
6457	1103	2.79	http://nnrwkwj.org/UFBOcto.js	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1533636040316-1a9598da3707?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8U3dlZGlzaCUyME1lYXRiYWxscyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
5421	1103	5.44	https://fyupdkl.org/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1485921198582-a55119c97421?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8QW5nZWwlMjBGb29kJTIwQ2FrZSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNzN8MA&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
3006	1103	4.12	http://skuoxsx.com/qdVRVEQ.svg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1608220874995-aa3e5301c676?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGhpbGFkZWxwaGlhJTIwd2l0aCUyMHNhbG1vbiUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3N3ww&ixlib=rb-4.0.3&q=80&w=1080	Philadelphia with salmon
9357	1103	2.68	http://www.msvjdec.com/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxXYWxsbWFydCUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyNXww&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
3565	1103	4.04	https://sjuixhr.info/tufRhYA.js	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1564489563601-c53cfc451e93?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8VG9ydGVsbGluaSUyMEJvd2xzJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA1NTgyfDA&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
9980	1103	5.82	https://czneyxx.edu/TXfFoiO.html	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1590452650110-3cf5fcb9c7b2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxQaXp6YSUyMHBpenphfGVufDB8fHx8MTcyNjAwNTU3NXww&ixlib=rb-4.0.3&q=80&w=1080	Pizza
9325	1103	2.93	http://lqhtgas.info/BweAgxi.html	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEhhd2FpaWFuJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA2MDc3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
3643	1103	4.81	https://nsdeays.com/WfmniML.jpg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1603596310923-dbb12732f9c7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQZWFudXQlMjBCdXR0ZXIlMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwMDU1ODB8MA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
1109	1103	4.01	http://xihbryh.top/ZLaPPmo.css	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1529139574466-a303027c1d8b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8TmV3JTIwWW9yayUyMFN0eWxlJTIwQ2hlZXNlY2FrZSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MjJ8MA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
8289	1103	6.84	http://jogftgl.info/VPKWaDU.php	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxDcmlzcHklMjBDaGlja2VuJTIwYnVyZ2VyJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2MTV8MA&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
9313	1103	6.67	http://qefqdql.info/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEhhd2FpaWFuJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA2MDc3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
9085	1103	5.64	https://mhbatxu.net/IrNqkYx.js	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxTd2VldCUyMFBvdGF0byUyMFBpZSUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
3623	1103	7.44	https://nbldeom.ru/rCCVpOO.html	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1576458088443-04a19bb13da6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8UGl6emElMjBJdGFsaWFubyUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjIyfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
997	1103	5.1	http://xgzhdab.net/uKWWpMp.css	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEhhd2FpaWFuJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA2MDc3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
41	1103	4.34	https://dbwxuzs.org/cIVkkKF.jpg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1593504049359-74330189a345?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBUZXhhcyUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYxM3ww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
5937	1103	3.14	http://itqjsdr.biz/TDMXDFK.js	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1508737027454-e6454ef45afd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxDaGlja2VuJTIwUG90JTIwUGllJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNTU3OXww&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
1316	1103	3.42	http://www.ttynlzn.net/WspmojT	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1611143669185-af224c5e3252?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxHcmFwZSUyMEplbGx5JTIwU2FuZHdpY2glMjBzdXNoaXxlbnwwfHx8fDE3MjYwMDU1Nzd8MA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
514	1103	5.06	https://www.frnbvef.info/shPuHkw	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEl0YWxpYW5vJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
4587	1103	2.29	https://tqilapn.net/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1590677147861-622ec92a60f6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8Q2hpY2tlbiUyMFBvdCUyMFBpZSUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
7749	1103	5.44	https://bapsimi.net/RAssWWf.php	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1499636136210-6f4ee915583e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8TmV3JTIwWW9yayUyMFN0eWxlJTIwQ2hlZXNlY2FrZSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDcwfDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
7488	1103	6.46	http://scqxrid.com/nTJQkBH.jpg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxHcmFwZSUyMEplbGx5JTIwU2FuZHdpY2glMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjA4OTYyNnww&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
3906	1103	6.34	https://wzwiqwo.info/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8UGl6emElMjBJdGFsaWFubyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNzJ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
4510	1103	5.38	http://www.vyimztk.edu/TBkSbWc	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1470259078422-826894b933aa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8TmV3JTIwWW9yayUyMFN0eWxlJTIwQ2hlZXNlY2FrZSUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA3Mnww&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
6656	1103	3.19	http://jhwldvo.edu/PNPRnFd.html	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1510297895683-0f27794412d5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGl6emElMjBPY2VhbiUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDU1NzZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
4608	1103	7.69	http://www.pvdgkbd.biz/iiMRYUd	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607246749144-7bc0e401623c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxVbmFnaSUyMFBoaWxhZGVscGhpYSUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA2OHww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
8425	1103	6.71	https://lbnxvmp.edu/EjsyIwx.html	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1508737027454-e6454ef45afd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxTd2VldCUyMFBvdGF0byUyMFBpZSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDU1NzR8MA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
3030	1103	5.96	https://www.aijvwlu.net/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1601924582970-9238bcb495d9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxVbmFnaSUyMFBoaWxhZGVscGhpYSUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyN3ww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
9840	1103	7.08	http://xatejvg.com/Qutmiyu.php	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1550547660-d9450f859349?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQZWFudXQlMjBCdXR0ZXIlMjBidXJnZXJ8ZW58MHx8fHwxNzI2MDg5NjE0fDA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
1247	1103	7.41	http://afgffyc.com/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1613371002402-208b2797ace3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8QmVhbiUyMEdyZWVuJTIwQ2hpbGklMjBCdXJyaXRvcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjA4OTYzMHww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
5816	1103	2.06	https://jdeqlff.info/TpLNnJf	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBJdGFsaWFubyUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYyNHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
7213	1103	6.19	http://mmriopx.org/mUSyKJH.css	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098731-5bf6416d2e8c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxTd2VkaXNoJTIwTWVhdGJhbGxzJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA1NTc3fDA&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
2548	1103	3.66	http://cyufode.info/bwnJMfS.php	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1606152196365-d1ce5ea838b5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8SGltYXdhcmklMjBwaXp6YXxlbnwwfHx8fDE3MjYwMDU1Nzh8MA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
3841	1103	3.88	http://orijirj.info/WCqvntc	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098912-8b2b44fde4d6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxDaGlja2VuJTIwUG90JTIwUGllJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
9502	1103	7.78	http://www.ohmfvsv.com/xejsLek	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1631214524049-0ebbbe6d81aa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNnx8VW5hZ2klMjBQaGlsYWRlbHBoaWElMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwODk2MTZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
3145	1103	7.65	https://phabikz.biz/BcbtBkf.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1579751626657-72bc17010498?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8VW53cmFwcGVkJTIwQnVycml0byUyMEJvd2wlMjBwaXp6YXxlbnwwfHx8fDE3MjYwODk2MzF8MA&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
2483	1103	7.14	https://vwswtte.info/fwbFrQl.webp	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098731-5bf6416d2e8c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQZWFudXQlMjBCdXR0ZXIlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjF8MA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
8962	1103	4.97	http://ttkujem.net/wVpijey.svg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1520072959219-c595dc870360?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8VW53cmFwcGVkJTIwQnVycml0byUyMEJvd2wlMjBidXJnZXJ8ZW58MHx8fHwxNzI2MDg5NjI4fDA&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
2255	1103	7.06	https://www.stcybxl.biz/WGnSKHb	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMEhhd2FpaWFuJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwMDYwNzN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
4406	1103	4.34	https://sojpkca.info/DrFLkDP.html	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMEhhd2FpaWFuJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwMDYwNzN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
2813	1103	2.61	http://wlyrmej.info/mxmWHUr.php	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxDaGlja2VuJTIwUG90JTIwUGllJTIwcGl6emF8ZW58MHx8fHwxNzI2MDg5NjIwfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
8333	1103	2.22	https://oswtstl.org/GuPIbpT.webp	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEhhd2FpaWFuJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA2MDc3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
1670	1103	5.65	http://rydtwjc.info/FRqJOXR.css	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1649219025763-bb4a23fdf256?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxBbmdlbCUyMEZvb2QlMjBDYWtlJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwMDYwNzB8MA&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
1074	1103	4.54	http://tmnhfzd.top/lasQGWO.webp	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1604186838309-c6715f0d3e6c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxXYWxsbWFydCUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjA4OTYxOXww&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
3734	1103	2.23	http://xqpppug.biz/ZtxvXNj.css	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1601924582970-9238bcb495d9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBUZXhhcyUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
3770	1103	3.89	https://iljpmby.biz/cKXPjOP	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1506459225024-1428097a7e18?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8Q2hpY2tlbiUyMFBvdCUyMFBpZSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA1NTgwfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
572	1103	6.37	https://lrbahbk.edu/CkOABcy.php	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8UGl6emElMjBJdGFsaWFubyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNzJ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
4605	1103	2.03	https://qrtalye.net/EQEZymQ	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxUb3J0ZWxsaW5pJTIwQm93bHMlMjBwaXp6YXxlbnwwfHx8fDE3MjYwMDYwNzN8MA&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
9390	1103	5.81	http://rlgoamg.info/GLRunnE.webp	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
7628	1103	4.39	http://pbypywc.org/fpCXrrG.css	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1542342656241-f23fedd6bafa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNjd8MA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
6679	1103	3.84	https://xiynbkc.edu/eihTHEE.jpg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1562158147-f8d6fbcd76f8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8SGltYXdhcmklMjBzdXNoaXxlbnwwfHx8fDE3MjYwMDYwNjh8MA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
5268	1103	4.67	http://www.naknsph.com/gTjbUgV	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8UGl6emElMjBJdGFsaWFubyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNzJ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
4064	1103	3.21	https://esnkxsu.net/ujryBmd	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjIxfDA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
7913	1103	3.43	https://pksqbmr.net/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8QmFjb24lMjBDaGVlc2UlMjBCdXJnZXIlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2Mjd8MA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
8057	1103	6.66	https://skdiaau.edu/LWdNBrv	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1508737027454-e6454ef45afd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxDcmlzcHklMjBDaGlja2VuJTIwYnVyZ2VyJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA1NTgzfDA&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
9401	1103	7.61	https://nsrnwkt.net/roSfSWe.svg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1508737027454-e6454ef45afd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxDcmlzcHklMjBDaGlja2VuJTIwYnVyZ2VyJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA1NTgzfDA&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
3352	2965	2.89	http://dsctxtb.biz/JKjhJgi.php	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1520072959219-c595dc870360?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8VW53cmFwcGVkJTIwQnVycml0byUyMEJvd2wlMjBidXJnZXJ8ZW58MHx8fHwxNzI2MDg5NjI4fDA&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
5877	2965	6.75	https://hvgmfdi.ru/htpDETB.webp	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxPcmlnaW5hbCUyMGJ1cmdlciUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDczfDA&ixlib=rb-4.0.3&q=80&w=1080	Original burger
3013	2965	5.15	http://www.fmpzyxa.ru/jDfLypZ	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1525059696034-4967a8e1dca2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8VG9ydGVsbGluaSUyMEJvd2xzJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNjA3Nnww&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
5153	2965	2.68	https://www.enagaih.top/yRwbjqO	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098731-5bf6416d2e8c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxTd2VkaXNoJTIwTWVhdGJhbGxzJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA1NTc3fDA&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
3441	2965	3.71	https://www.bddjmfu.biz/YyxuBIy	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1568901346375-23c9450c58cd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxIaW1hd2FyaSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTh8MA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
172	2965	6.02	http://fxepgsq.biz/DbCvxZM.php	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyME9jZWFuJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjE4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
8651	2965	3.82	http://dhjfufm.info/yviPGjH.jpg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBUZXhhcyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MjN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
9810	2965	4.27	https://www.vywpksz.com/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1653249288113-ed6e0db195a3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxCZWFuJTIwR3JlZW4lMjBDaGlsaSUyMEJ1cnJpdG9zJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwMDU1NzZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
9437	2965	3.84	http://wqvxyoz.org/ksyonCJ.js	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1468218620578-e8d78dcda7b1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxVbndyYXBwZWQlMjBCdXJyaXRvJTIwQm93bCUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA1NTgxfDA&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
3900	2965	2.36	http://sioyuru.ru/RpjIWaP.html	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1525203135335-74d272fc8d9c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8U3dlZGlzaCUyME1lYXRiYWxscyUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA1NTgzfDA&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
5781	2965	2.55	http://www.oolitnx.org/yyTxbVF	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1571997478779-2adcbbe9ab2f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxOZXclMjBZb3JrJTIwU3R5bGUlMjBDaGVlc2VjYWtlJTIwcGl6emF8ZW58MHx8fHwxNzI2MDg5NjI5fDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
1152	2965	5.09	https://www.xayxysg.ru/OiRAufD	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1521305916504-4a1121188589?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxHcmFwZSUyMEplbGx5JTIwU2FuZHdpY2glMjBidXJnZXJ8ZW58MHx8fHwxNzI2MDA1NTg0fDA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
8148	2965	2.55	https://www.aurtgds.ru/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1513553404607-988bf2703777?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8UGl6emElMjBPY2VhbiUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2N3ww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
3888	2965	4.7	https://ntkdynn.com/oQqAxPW.html	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1531722596216-1fb4fbace9b7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxOZXclMjBZb3JrJTIwU3R5bGUlMjBDaGVlc2VjYWtlJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjE0fDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
4760	2965	6.62	http://hsbcoxn.edu/ynhBqUp.php	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1513553404607-988bf2703777?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxQaXp6YSUyME9jZWFuJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2Mjl8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
8738	2965	2.18	http://www.avowytm.org/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1611143669185-af224c5e3252?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxHcmFwZSUyMEplbGx5JTIwU2FuZHdpY2glMjBzdXNoaXxlbnwwfHx8fDE3MjYwMDU1Nzd8MA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
6396	2965	3.73	https://wgywyjc.top/cOwPHRx.webp	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607246749144-7bc0e401623c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxVbmFnaSUyMFBoaWxhZGVscGhpYSUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA2OHww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
1968	2965	3.44	https://yalrdiw.com/OLHTtBb.js	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098912-8b2b44fde4d6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxDaGlja2VuJTIwUG90JTIwUGllJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
2522	2965	3.29	http://ctnfefd.org/iPWOxyR.js	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098729-accb1f156620?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxVbndyYXBwZWQlMjBCdXJyaXRvJTIwQm93bCUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNTU3OHww&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
5765	2965	5.99	http://uifvvww.biz/uoRURbO.php	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1513553404607-988bf2703777?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8UGl6emElMjBPY2VhbiUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2N3ww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
8498	2965	3.32	http://vetibfa.org/byAQtig.webp	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
9742	2965	2.88	https://mhzbnni.org/kMUcRWD.php	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjI2fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
651	2965	5.18	http://oyrilcd.org/bWsamHO.svg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1456324463128-7ff6903988d8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8U2FpbnQlMjBGcmFuayUyMENvZmZlZSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDU1ODR8MA&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
4390	2965	5.07	http://durspdg.net/mFptXSK.svg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1590452650110-3cf5fcb9c7b2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxQaXp6YSUyMHBpenphfGVufDB8fHx8MTcyNjAwNTU3NXww&ixlib=rb-4.0.3&q=80&w=1080	Pizza
3260	2965	7.95	https://dyhyhhe.biz/ZwYPlHF.svg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1499636136210-6f4ee915583e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxIaW1hd2FyaSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA1NTc4fDA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
8114	2965	5.48	https://hmolras.info/fxeMRKx.webp	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1510297895683-0f27794412d5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGl6emElMjBPY2VhbiUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDU1NzZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
4901	2965	7.05	https://www.ametecz.edu/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1643078726430-fed25cc73ea3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxIaW1hd2FyaSUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNTU3OXww&ixlib=rb-4.0.3&q=80&w=1080	Himawari
7729	2965	7.35	https://jkqhycj.edu/xDIJfyl.css	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGl6emElMjBGbG9yaWRhJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
6161	2965	5.26	https://ezmcqhd.info/ucpsyFK.jpg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1495147466023-ac5c588e2e94?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxUb3J0ZWxsaW5pJTIwQm93bHMlMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3OHww&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
3726	2965	6.48	https://cibjadb.top/SgokUVq.js	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1569761316261-9a8696fa2ca3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8VW5hZ2klMjBQaGlsYWRlbHBoaWElMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjA4OTYxN3ww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
1804	2965	3.94	https://vctokhh.top/UbghREN.js	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1472393365320-db77a5abbecc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8UGl6emElMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MTJ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza
6780	2965	5.71	http://iqbgopw.ru/rpOfeth.webp	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1608220874995-aa3e5301c676?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGhpbGFkZWxwaGlhJTIwd2l0aCUyMHNhbG1vbiUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3N3ww&ixlib=rb-4.0.3&q=80&w=1080	Philadelphia with salmon
4907	2965	5.11	https://smwwuau.biz/eBwaihR.svg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1456324463128-7ff6903988d8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8U2FpbnQlMjBGcmFuayUyMENvZmZlZSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDU1ODR8MA&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
4554	2965	2.81	http://kukwrox.net/aoNbAlw.svg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGl6emElMjBGbG9yaWRhJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
3710	2965	8	http://www.jhszosa.edu/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1508736793122-f516e3ba5569?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxPcmlnaW5hbCUyMGJ1cmdlciUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNjZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Original burger
7365	2965	2.16	http://ktdwmwq.com/KOvuPft.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxTd2VldCUyMFBvdGF0byUyMFBpZSUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
7508	2965	6.32	http://bayrajl.com/CfjVHxD.svg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxQaXp6YSUyMEhhd2FpaWFuJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA2MDczfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
1940	2965	5.26	https://chsqzqk.biz/CXniSmj.jpg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1643078726430-fed25cc73ea3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxIaW1hd2FyaSUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNTU3OXww&ixlib=rb-4.0.3&q=80&w=1080	Himawari
746	2965	6.71	http://chwehua.edu/XfBxrqC.jpg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1604186838309-c6715f0d3e6c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxXYWxsbWFydCUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjA4OTYxOXww&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
3465	2965	4.39	https://www.gloaovm.com/atxBMaI	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1590677147861-622ec92a60f6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8Q2hpY2tlbiUyMFBvdCUyMFBpZSUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
447	2965	6.18	https://hcbjutf.top/JkwaybW	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBGbG9yaWRhJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
8260	2965	3.48	http://bhfghog.org/HitHgEK	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1520072959219-c595dc870360?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8U3dlZGlzaCUyME1lYXRiYWxscyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MjR8MA&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
5879	2965	7.91	https://wnngsef.info/NfNFcpk.svg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8QmFjb24lMjBDaGVlc2UlMjBCdXJnZXIlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2Mjd8MA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
3930	2965	2.58	http://riufxbn.info/AwUjbht.svg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1513553404607-988bf2703777?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8UGl6emElMjBPY2VhbiUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2N3ww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
2952	2965	3.24	https://avyuval.edu/sGctuMD.css	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1494314671902-399b18174975?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxTYWludCUyMEZyYW5rJTIwQ29mZmVlJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2MjN8MA&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
8125	2965	7.73	http://zfvvgml.biz/XyKotOv	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1542342656241-f23fedd6bafa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNjd8MA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
6228	2965	6.37	http://mqyirkr.net/MCdEGFA.html	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjIxfDA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
6294	2965	7.55	http://jpqomfi.biz/ZWiAxkL.svg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1521401292936-0a2129a30b1c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxTYWludCUyMEZyYW5rJTIwQ29mZmVlJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA1NTgyfDA&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
9733	2965	3.43	https://jmqkssi.info/aAxjKhD.css	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8Q3Jpc3B5JTIwQ2hpY2tlbiUyMGJ1cmdlciUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYxOXww&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
7330	2965	3.66	http://www.wiafecb.net/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1586985289688-ca3cf47d3e6e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8UGhpbGFkZWxwaGlhJTIwd2l0aCUyMHNhbG1vbiUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA1NTg1fDA&ixlib=rb-4.0.3&q=80&w=1080	Philadelphia with salmon
9858	2965	2.91	http://eukncnk.org/UZdDusY.js	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGl6emElMjBGbG9yaWRhJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
8025	2965	7.16	http://gymmcpm.top/PtPnbNj.webp	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1521305916504-4a1121188589?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxHcmFwZSUyMEplbGx5JTIwU2FuZHdpY2glMjBidXJnZXJ8ZW58MHx8fHwxNzI2MDA1NTg0fDA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
5497	2965	5.19	http://yjcmwow.top/LoKdpmO.jpg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1513553404607-988bf2703777?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxQaXp6YSUyME9jZWFuJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2Mjl8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
5062	2965	4.44	https://irtcguw.edu/sEUTSOj.js	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1603596310923-dbb12732f9c7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQZWFudXQlMjBCdXR0ZXIlMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwMDU1ODB8MA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
7148	2965	3.27	http://fnopfme.org/mDvbbuR	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1506459225024-1428097a7e18?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8Q2hpY2tlbiUyMFBvdCUyMFBpZSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA1NTgwfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
377	2965	5.59	http://nhvwpfe.edu/jtrRiED.jpg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBUZXhhcyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MjN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
1548	2965	7.99	http://xpxpjjl.net/cXpyupD.jpg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8U3dlZXQlMjBQb3RhdG8lMjBQaWUlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
6723	2965	2.95	https://mixfuuu.info/vwkIFjn.php	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBJdGFsaWFubyUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYyNHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
2990	2965	5.69	https://huusnof.org/MCPQeHb.js	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1576458088443-04a19bb13da6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8UGl6emElMjBJdGFsaWFubyUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjIyfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
740	2965	2.14	https://wqtjzuu.org/EHTLoWB.jpg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1590677147861-622ec92a60f6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8Q2hpY2tlbiUyMFBvdCUyMFBpZSUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
7752	2965	4.06	http://www.uauskyf.edu/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1601924582970-9238bcb495d9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxVbmFnaSUyMFBoaWxhZGVscGhpYSUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyN3ww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
1683	2965	5.34	https://bqixwgm.info/GeEsgae.jpg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1499636136210-6f4ee915583e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxIaW1hd2FyaSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA1NTc4fDA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
5415	2965	5.83	http://www.wlglepw.com/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1564489563601-c53cfc451e93?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8VG9ydGVsbGluaSUyMEJvd2xzJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA1NTgyfDA&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
3876	2965	7.79	http://www.suhpmyv.net/LngSHGr	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxHcmFwZSUyMEplbGx5JTIwU2FuZHdpY2glMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjA4OTYyNnww&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
6622	2965	6.02	https://dsfjxfg.org/BPqmsKO.js	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1611143669185-af224c5e3252?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxDcmlzcHklMjBDaGlja2VuJTIwYnVyZ2VyJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjI5fDA&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
8750	2965	6.02	http://www.ojmuuhk.edu/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxUb3J0ZWxsaW5pJTIwQm93bHMlMjBwaXp6YXxlbnwwfHx8fDE3MjYwMDYwNzN8MA&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
1568	2965	4.22	http://uwikyym.top/RbWKXbD	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1617957796155-72d8717ac882?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxCZWFuJTIwR3JlZW4lMjBDaGlsaSUyMEJ1cnJpdG9zJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjA4OTYxM3ww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
1481	2965	6.37	https://lngqqbj.edu/gGxYQRf.svg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBJdGFsaWFubyUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYyNHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
6670	2965	7.95	https://qyftjxa.ru/jNEGtms	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1593504049359-74330189a345?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBUZXhhcyUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYxM3ww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
6907	2965	7	https://lfqibhf.net/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1476887334197-56adbf254e1a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxXYWxsbWFydCUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjMwfDA&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
5961	2965	5.18	https://rahwcej.com/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxQaXp6YSUyMEhhd2FpaWFuJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA2MDczfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
8847	2965	7.55	http://vhrfgra.net/uOJJUJb	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGl6emElMjBGbG9yaWRhJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
8953	2965	2.87	https://fmnyjta.edu/GeAYihk.svg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1484199383121-dfa3c30608cd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBGbG9yaWRhJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2MTl8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
8635	417	5.62	http://qmmvpnb.org/MQkMhim.jpg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/31/RpgvvtYAQeqAIs1knERU_vegetables.jpg?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8QW5nZWwlMjBGb29kJTIwQ2FrZSUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3NXww&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
7274	417	2.81	https://www.wujkrgt.net/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1499636136210-6f4ee915583e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8TmV3JTIwWW9yayUyMFN0eWxlJTIwQ2hlZXNlY2FrZSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDcwfDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
3985	417	7.91	http://www.ypgmggq.org/GYKjQpf	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1518977877150-35db786d223a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8QmVhbiUyMEdyZWVuJTIwQ2hpbGklMjBCdXJyaXRvcyUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3N3ww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
3000	417	5.8	http://aoitshu.edu/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1521401292936-0a2129a30b1c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxTYWludCUyMEZyYW5rJTIwQ29mZmVlJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA1NTgyfDA&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
2367	417	4.15	http://ubbmfah.net/aqovVcK.svg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1494314671902-399b18174975?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxTYWludCUyMEZyYW5rJTIwQ29mZmVlJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2MjN8MA&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
8936	417	3.47	http://ovjdvvq.info/JhUdOPI.html	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1707616954145-4483a30ca077?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8VG9ydGVsbGluaSUyMEJvd2xzJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA2MDY5fDA&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
8678	417	6.16	https://fejuncs.ru/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1611143669185-af224c5e3252?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxHcmFwZSUyMEplbGx5JTIwU2FuZHdpY2glMjBzdXNoaXxlbnwwfHx8fDE3MjYwMDU1Nzd8MA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
2345	417	4.79	https://kpmeswu.com/SDRutoO.php	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1706954225234-fe9808ce3d72?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
5312	417	5.39	http://ellytvy.org/JtwgwGf.webp	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1550547660-d9450f859349?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQZWFudXQlMjBCdXR0ZXIlMjBidXJnZXJ8ZW58MHx8fHwxNzI2MDg5NjE0fDA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
4225	417	5.27	http://vyjjivs.edu/wvohfxH.php	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxQaXp6YSUyMEl0YWxpYW5vJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA1NTc2fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
9640	417	6.68	http://pagotae.com/LYngHxX.svg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjIxfDA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
4963	417	2.39	http://fzjnfrj.com/DNMLQQG.svg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1542342656241-f23fedd6bafa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNjd8MA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
4468	417	4.07	http://xothnef.biz/SVcjgVC.php	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1521401292936-0a2129a30b1c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxTYWludCUyMEZyYW5rJTIwQ29mZmVlJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA1NTgyfDA&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
1309	417	6.13	http://alyomnl.top/eeBZJer.html	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1508737027454-e6454ef45afd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxTd2VldCUyMFBvdGF0byUyMFBpZSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDU1NzR8MA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
7209	417	5.12	http://hubwfdn.info/PZsoAmR.css	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGl6emElMjBGbG9yaWRhJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
4567	417	4.04	https://nhmgkux.com/omeNrBL.svg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1613371002402-208b2797ace3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8QmVhbiUyMEdyZWVuJTIwQ2hpbGklMjBCdXJyaXRvcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjA4OTYzMHww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
9163	417	3.85	https://rutqdzd.edu/JvanEte	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1586985289688-ca3cf47d3e6e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8UGhpbGFkZWxwaGlhJTIwd2l0aCUyMHNhbG1vbiUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA1NTg1fDA&ixlib=rb-4.0.3&q=80&w=1080	Philadelphia with salmon
1131	417	7.32	http://kzdmhgz.edu/grXcJcZ.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600628421055-4d30de868b8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGVhbnV0JTIwQnV0dGVyJTIwcGl6emF8ZW58MHx8fHwxNzI2MDg5NjEyfDA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
3469	417	3.26	http://qmlvdef.info/bcpdPAu.css	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607246749144-7bc0e401623c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxPcmlnaW5hbCUyMGJ1cmdlciUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYxNnww&ixlib=rb-4.0.3&q=80&w=1080	Original burger
8631	417	6.48	http://www.qreykyd.org/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGl6emElMjBGbG9yaWRhJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
2415	417	4.76	http://www.bqeyngs.ru/BXZYGvU	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
1078	417	4.47	https://hkhmxus.org/lMFgert.svg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1484199383121-dfa3c30608cd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBGbG9yaWRhJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2MTl8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
7885	417	4.74	https://ejvkrjl.biz/UGaXsRq.css	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607246749144-7bc0e401623c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxPcmlnaW5hbCUyMGJ1cmdlciUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYxNnww&ixlib=rb-4.0.3&q=80&w=1080	Original burger
7026	417	6.17	https://www.nwvayhc.biz/HbxZtqd	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1499636136210-6f4ee915583e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8TmV3JTIwWW9yayUyMFN0eWxlJTIwQ2hlZXNlY2FrZSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDcwfDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
7218	417	4.57	http://uivadwl.com/cSwEAeO.jpg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1531722596216-1fb4fbace9b7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxOZXclMjBZb3JrJTIwU3R5bGUlMjBDaGVlc2VjYWtlJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjE0fDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
9965	417	7.11	http://www.pkolkfl.biz/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607246749144-7bc0e401623c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxVbmFnaSUyMFBoaWxhZGVscGhpYSUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA2OHww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
3271	417	4.95	https://winwdwm.biz/AMoHABb	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1651870347822-d5cf1ce4e28f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8QmVhbiUyMEdyZWVuJTIwQ2hpbGklMjBCdXJyaXRvcyUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA3N3ww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
9710	417	7.37	https://ftbkoov.org/nVqJbGS.php	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1456324463128-7ff6903988d8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8U2FpbnQlMjBGcmFuayUyMENvZmZlZSUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyN3ww&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
8598	417	4.67	http://www.ghekvfn.ru/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGl6emElMjBGbG9yaWRhJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
7001	417	3.37	http://dqsqwsd.org/KXkkNXu	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1495147466023-ac5c588e2e94?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxUb3J0ZWxsaW5pJTIwQm93bHMlMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3OHww&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
9200	417	4.5	http://xnhhjoe.info/FNHMjTo.css	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGl6emElMjBGbG9yaWRhJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
138	417	7.85	http://rcxkwjf.edu/TGnekkg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEhhd2FpaWFuJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA2MDc3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
9749	417	5.73	https://stmcplp.ru/wKRWJhe.php	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8QmFjb24lMjBDaGVlc2UlMjBCdXJnZXIlMjBwaXp6YXxlbnwwfHx8fDE3MjYwMDU1NzV8MA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
645	4384	4.57	http://waubevy.biz/PhPxKTR.svg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1628191013647-5640e14ded54?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8R3JhcGUlMjBKZWxseSUyMFNhbmR3aWNoJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjE3fDA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
173	4384	6.07	https://dwtfave.biz/MwEltLr.css	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/31/RpgvvtYAQeqAIs1knERU_vegetables.jpg?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8QW5nZWwlMjBGb29kJTIwQ2FrZSUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3NXww&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
554	4384	6.26	https://rpltzrb.org/gKhKjTS.js	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxXYWxsbWFydCUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTV8MA&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
2139	4384	3.81	https://www.dipdbsg.net/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1542342656241-f23fedd6bafa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNjd8MA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
6813	4384	5.43	https://sbathqu.com/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098912-8b2b44fde4d6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxDaGlja2VuJTIwUG90JTIwUGllJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
4604	4384	7.54	http://oldkjwk.top/BVbQDfR	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBUZXhhcyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MjN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
9861	4384	7.24	http://fqqpdlo.edu/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEhhd2FpaWFuJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA2MDc3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
2301	4384	2.28	https://www.pphhojl.ru/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1550547660-d9450f859349?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQZWFudXQlMjBCdXR0ZXIlMjBidXJnZXJ8ZW58MHx8fHwxNzI2MDg5NjE0fDA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
2835	4384	3.01	http://qmgftwm.org/OaCRvdy	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1506459225024-1428097a7e18?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8Q2hpY2tlbiUyMFBvdCUyMFBpZSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA1NTgwfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
2224	4384	3.5	https://skqktkl.edu/CPuSKUm.js	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjI2fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
4230	4384	4.92	https://lmawlyx.net/ENWrCGx.css	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBJdGFsaWFubyUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYyNHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
3848	4384	4.88	https://www.pfjkhhi.net/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBIYXdhaWlhbiUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
9974	4384	3.77	http://www.esepvjt.edu/yWvnXBa	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1564489563601-c53cfc451e93?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8VG9ydGVsbGluaSUyMEJvd2xzJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA1NTgyfDA&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
9926	4384	4.45	https://zbhyehe.org/pxTtbVL.svg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8U3dlZXQlMjBQb3RhdG8lMjBQaWUlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
7332	4384	7.7	https://nmhsvmu.ru/ZBRHtOh.jpg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGl6emElMjBGbG9yaWRhJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
6055	4384	3.12	https://rlvfiyf.net/wVyJAiy.webp	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1476887334197-56adbf254e1a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxXYWxsbWFydCUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjMwfDA&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
7010	4384	5.35	http://teqdwjk.net/uruBlvo	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
7993	4384	4.4	http://www.boaeymv.com/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMEhhd2FpaWFuJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwMDYwNzN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
3541	4384	7.54	https://dguxnea.info/YFytKSb.css	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1590452650110-3cf5fcb9c7b2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxQaXp6YSUyMHBpenphfGVufDB8fHx8MTcyNjAwNTU3NXww&ixlib=rb-4.0.3&q=80&w=1080	Pizza
917	4384	5.42	http://zeahkxk.top/uriJDOu.css	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1579751626657-72bc17010498?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8UGl6emElMjBGbG9yaWRhJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNjA3NHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
6076	4384	6.96	http://punhcjp.org/IQCXWRl.php	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyME9jZWFuJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjE4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
4858	4384	5.48	https://mthnqxc.org/jTFrawy	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098731-5bf6416d2e8c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxTd2VkaXNoJTIwTWVhdGJhbGxzJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA1NTc3fDA&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
1573	4384	7.54	http://www.feliszm.info/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1513553404607-988bf2703777?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOHx8UGl6emElMjBPY2VhbiUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2N3ww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
9871	4384	2.74	http://npsqnaw.biz/XXwghcd.php	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1521305916504-4a1121188589?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxHcmFwZSUyMEplbGx5JTIwU2FuZHdpY2glMjBidXJnZXJ8ZW58MHx8fHwxNzI2MDA1NTg0fDA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
4644	4384	7.33	https://wzndyqj.info/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8QmFjb24lMjBDaGVlc2UlMjBCdXJnZXIlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2Mjd8MA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
9914	4384	6.33	http://cbnnifc.biz/dlkJGAW.js	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1521401292936-0a2129a30b1c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxTYWludCUyMEZyYW5rJTIwQ29mZmVlJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA1NTgyfDA&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
5064	4384	2.96	https://www.yxnwxtf.com/ZnliiJj	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1494314671902-399b18174975?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxTYWludCUyMEZyYW5rJTIwQ29mZmVlJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2MjN8MA&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
8977	4384	4.33	https://btdmpdb.biz/aLvhapb	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
1120	4384	4.39	http://jqdoodo.net/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1456324463128-7ff6903988d8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8U2FpbnQlMjBGcmFuayUyMENvZmZlZSUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyN3ww&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
8380	4384	5.53	http://fdfjper.biz/sJdtCfR.css	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjIxfDA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
9941	4384	4.77	https://qtkzjjx.biz/msFqpEO	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBIYXdhaWlhbiUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
9824	4384	4.37	https://www.gwwahlx.info/fiWnRDg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxQaXp6YSUyMEZsb3JpZGElMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjB8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
8158	4384	7.71	http://nenpwxl.org/AamFBXn.jpg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098731-5bf6416d2e8c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQZWFudXQlMjBCdXR0ZXIlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjF8MA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
3986	4384	5	https://zlkahzj.com/ZSCZEAY.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEl0YWxpYW5vJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
8208	4384	2.35	http://www.uydqwse.net/MpQqkQF	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1533910534207-90f31029a78e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8U3dlZXQlMjBQb3RhdG8lMjBQaWUlMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwMDYwNzV8MA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
7492	4384	5.7	http://fskrkey.edu/NEcFfoX.css	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098731-5bf6416d2e8c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxTd2VkaXNoJTIwTWVhdGJhbGxzJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA1NTc3fDA&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
6981	4384	4.57	https://avjgvkm.ru/QFFGQMZ.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxTd2VldCUyMFBvdGF0byUyMFBpZSUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
6223	4384	7.84	http://judgtdd.top/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1571997478779-2adcbbe9ab2f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxOZXclMjBZb3JrJTIwU3R5bGUlMjBDaGVlc2VjYWtlJTIwcGl6emF8ZW58MHx8fHwxNzI2MDg5NjI5fDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
2442	4384	3.25	https://qbascid.net/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxQaXp6YSUyMEZsb3JpZGElMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjB8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
2601	4384	5.2	https://adnrsiw.info/WktOncF.js	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1590677147861-622ec92a60f6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8Q2hpY2tlbiUyMFBvdCUyMFBpZSUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
583	4384	7.41	https://gzekanr.net/aUDNYbn.svg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1520072959219-c595dc870360?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8VW53cmFwcGVkJTIwQnVycml0byUyMEJvd2wlMjBidXJnZXJ8ZW58MHx8fHwxNzI2MDg5NjI4fDA&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
7788	4384	6.72	https://xuxemyl.biz/WuSICXy.php	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8R3JhcGUlMjBKZWxseSUyMFNhbmR3aWNoJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDc1fDA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
641	4384	4.92	http://grhtwru.biz/bFLlxlm.php	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1707616954145-4483a30ca077?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8VG9ydGVsbGluaSUyMEJvd2xzJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDA2MDY5fDA&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
6745	4384	4.12	https://ltscors.com/aiUlpJs.webp	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1541544741938-0af808871cc0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNTU3NHww&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
6855	4384	2.59	https://www.bbkhkfk.org/uhUOdAT	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8UGl6emElMjBUZXhhcyUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDc1fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
8145	4384	4.09	http://vpbxepv.net/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxDcmlzcHklMjBDaGlja2VuJTIwYnVyZ2VyJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2MTV8MA&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
4063	4384	3.54	http://ketrsyt.ru/ZcNtsiM.php	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1631214524049-0ebbbe6d81aa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNnx8VW5hZ2klMjBQaGlsYWRlbHBoaWElMjBmcm96ZW5fbWVhbHxlbnwwfHx8fDE3MjYwODk2MTZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
5590	4384	7.12	https://risdnwb.info/CToKAvA.css	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1484199383121-dfa3c30608cd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBGbG9yaWRhJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwODk2MTl8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
5721	4384	3.01	http://eilvlql.org/ONLgxyI.js	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxUb3J0ZWxsaW5pJTIwQm93bHMlMjBwaXp6YXxlbnwwfHx8fDE3MjYwMDYwNzN8MA&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
6024	4384	3.17	https://mooicrc.biz/pLyqnSf.php	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMEhhd2FpaWFuJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwMDYwNzN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
5951	4384	4.74	https://piabmjm.net/Ihrewux.jpg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1518977877150-35db786d223a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8QmVhbiUyMEdyZWVuJTIwQ2hpbGklMjBCdXJyaXRvcyUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3N3ww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
5842	4384	4.12	https://qhzkpjp.net/NMCrchY.html	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1476887334197-56adbf254e1a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxXYWxsbWFydCUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjMwfDA&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
2473	4384	4.13	https://njgajvd.net/nxqNgMl.css	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1562158147-f8d6fbcd76f8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8SGltYXdhcmklMjBzdXNoaXxlbnwwfHx8fDE3MjYwMDYwNjh8MA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
9318	4384	6.24	http://hdjpqnw.com/kGmWfSN.html	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8U3dlZXQlMjBQb3RhdG8lMjBQaWUlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
1507	4384	2.91	http://www.ipkfbcm.biz/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1670338512239-556181fff224?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8UGl6emElMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Pizza
8870	4384	5.7	http://tafqgtp.edu/pVCWWWf.css	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxXYWxsbWFydCUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTV8MA&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
364	4384	7.71	http://www.kngrotc.biz/KMxrkYX	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
2379	4384	6.95	https://ecjxyyr.com/cWJQDeM.webp	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1511378156040-1259b5bcd0fb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxVbndyYXBwZWQlMjBCdXJyaXRvJTIwQm93bCUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
5315	4384	4.98	http://mxnhkvx.biz/niGLvGG.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1606152196365-d1ce5ea838b5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8SGltYXdhcmklMjBwaXp6YXxlbnwwfHx8fDE3MjYwMDU1Nzh8MA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
1237	4384	5.12	https://wnlpmkw.biz/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1613371002402-208b2797ace3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8QmVhbiUyMEdyZWVuJTIwQ2hpbGklMjBCdXJyaXRvcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjA4OTYzMHww&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
7085	4384	2.13	https://pbqwosr.info/rbWXvQY.js	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1520072959219-c595dc870360?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8U3dlZGlzaCUyME1lYXRiYWxscyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MjR8MA&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
9113	4384	6.03	https://ecggrtv.edu/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxPcmlnaW5hbCUyMGJ1cmdlciUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDczfDA&ixlib=rb-4.0.3&q=80&w=1080	Original burger
1557	4384	6.53	https://vhabcmf.com/nTamPox.css	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098729-accb1f156620?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxVbndyYXBwZWQlMjBCdXJyaXRvJTIwQm93bCUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNTU3OHww&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
8394	4384	6.24	http://daxhpgs.ru/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1670338512239-556181fff224?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8UGl6emElMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Pizza
127	4384	7.08	https://uosefqi.biz/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1495774856032-8b90bbb32b32?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxTYWludCUyMEZyYW5rJTIwQ29mZmVlJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjI1fDA&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
5705	4384	4.17	https://olyiduy.org/CugVfUO.php	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1550547660-d9450f859349?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQZWFudXQlMjBCdXR0ZXIlMjBidXJnZXJ8ZW58MHx8fHwxNzI2MDg5NjE0fDA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
6451	4384	4.31	https://jdnbyin.biz/vchUFhV.webp	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1579751626657-72bc17010498?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8UGl6emElMjBGbG9yaWRhJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNjA3NHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
5145	4384	2.03	https://gllicgz.biz/suMTBFy.css	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8QmFjb24lMjBDaGVlc2UlMjBCdXJnZXIlMjBwaXp6YXxlbnwwfHx8fDE3MjYwMDU1NzV8MA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
2810	4384	7.85	http://ossdhwq.biz/gqlhWZr.html	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1649219025763-bb4a23fdf256?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxBbmdlbCUyMEZvb2QlMjBDYWtlJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwMDYwNzB8MA&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
3049	4384	6.05	http://tugarqt.org/crZAWWv.html	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1564489563601-c53cfc451e93?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8VG9ydGVsbGluaSUyMEJvd2xzJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA1NTgyfDA&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
9019	4384	2.3	https://djuiiyk.top/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1521305916504-4a1121188589?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxHcmFwZSUyMEplbGx5JTIwU2FuZHdpY2glMjBidXJnZXJ8ZW58MHx8fHwxNzI2MDA1NTg0fDA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
268	4384	5.71	http://jphbagc.edu/RUbFplu.js	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600628421055-4d30de868b8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGVhbnV0JTIwQnV0dGVyJTIwcGl6emF8ZW58MHx8fHwxNzI2MDg5NjEyfDA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
7292	4384	3.42	https://www.fbsbmal.info/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1531722596216-1fb4fbace9b7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxOZXclMjBZb3JrJTIwU3R5bGUlMjBDaGVlc2VjYWtlJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjE0fDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
2080	4384	7.28	http://suhuyes.top/fysHuEq.svg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1531722596216-1fb4fbace9b7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxOZXclMjBZb3JrJTIwU3R5bGUlMjBDaGVlc2VjYWtlJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjE0fDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
866	4384	4.76	https://www.odtkrrp.biz/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1495147466023-ac5c588e2e94?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxUb3J0ZWxsaW5pJTIwQm93bHMlMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3OHww&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
9981	4384	6.65	http://zungdus.net/CKxforM.svg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1529139574466-a303027c1d8b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8TmV3JTIwWW9yayUyMFN0eWxlJTIwQ2hlZXNlY2FrZSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MjJ8MA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
8213	4384	3.33	http://qznciuz.org/BOVYZiW.js	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
7296	4384	7.38	https://bslmtqi.org/IphOuIQ.css	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1525203135335-74d272fc8d9c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8U3dlZGlzaCUyME1lYXRiYWxscyUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA1NTgzfDA&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
218	4384	4.76	http://acqggwv.biz/sSFIxxX.css	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxDcmlzcHklMjBDaGlja2VuJTIwYnVyZ2VyJTIwYnVyZ2VyfGVufDB8fHx8MTcyNjAwNjA2N3ww&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
1837	4384	4.18	http://ijngkqk.ru/HpLsyHw.js	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1456324463128-7ff6903988d8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8U2FpbnQlMjBGcmFuayUyMENvZmZlZSUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyN3ww&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
7027	4384	6.71	http://ghermlp.top/qTNVupo.svg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1579751626657-72bc17010498?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8VW53cmFwcGVkJTIwQnVycml0byUyMEJvd2wlMjBwaXp6YXxlbnwwfHx8fDE3MjYwODk2MzF8MA&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
1110	4384	5.19	https://www.tlcoqhk.com/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxXYWxsbWFydCUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTV8MA&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
5172	4384	4.43	https://pyrnbbq.net/vJpAhcj.webp	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1485921198582-a55119c97421?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8QW5nZWwlMjBGb29kJTIwQ2FrZSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNzN8MA&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
8747	4384	7.99	http://naqravm.edu/mfBOdBo.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8QmFjb24lMjBDaGVlc2UlMjBCdXJnZXIlMjBwaXp6YXxlbnwwfHx8fDE3MjYwMDU1NzV8MA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
7356	4384	5.38	http://ealhgjh.ru/viQeWff.php	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1601924582970-9238bcb495d9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBUZXhhcyUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
3400	4384	3.68	https://napktqk.net/lEkQcJc	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1495147466023-ac5c588e2e94?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxUb3J0ZWxsaW5pJTIwQm93bHMlMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3OHww&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
3080	4384	2.01	http://zptrfbx.info/rgtBkJR.webp	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098912-8b2b44fde4d6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxDaGlja2VuJTIwUG90JTIwUGllJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
1684	4384	7.03	https://cfamtcf.net/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1606152196365-d1ce5ea838b5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8SGltYXdhcmklMjBwaXp6YXxlbnwwfHx8fDE3MjYwMDU1Nzh8MA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
3508	4384	5.74	http://vdeevxj.edu/ZmTZPHB.webp	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1521401292936-0a2129a30b1c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxTYWludCUyMEZyYW5rJTIwQ29mZmVlJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA1NTgyfDA&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
3873	4384	7.42	https://ipmsmeq.top/	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1611143669185-af224c5e3252?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxDcmlzcHklMjBDaGlja2VuJTIwYnVyZ2VyJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjI5fDA&ixlib=rb-4.0.3&q=80&w=1080	Crispy Chicken burger
1910	4384	6.7	https://susdbkx.info/gNZFsvR.svg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8UGl6emElMjBUZXhhcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNTU4MHww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
1844	4384	7.58	http://uiugmqm.biz/trXdSmc.html	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1593504049359-74330189a345?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBUZXhhcyUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYxM3ww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Texas
9063	4384	2.92	https://pfutulg.top/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxHcmFwZSUyMEplbGx5JTIwU2FuZHdpY2glMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjA4OTYyNnww&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
2874	4384	2.71	http://wsdtvsh.ru/xhiEoCu.webp	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1499636136210-6f4ee915583e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyMHx8TmV3JTIwWW9yayUyMFN0eWxlJTIwQ2hlZXNlY2FrZSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDcwfDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
6342	4384	2.09	https://vxekkdh.biz/adUIWxn.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMnx8UGl6emElMjBGbG9yaWRhJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY3fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
9171	4384	5.9	http://utlstvh.biz/rDccFGM.jpg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1601332069884-15a8149df78a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8UGhpbGFkZWxwaGlhJTIwd2l0aCUyMHNhbG1vbiUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2Mjh8MA&ixlib=rb-4.0.3&q=80&w=1080	Philadelphia with salmon
5772	4384	2.03	http://avyjbgt.net/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1568901346375-23c9450c58cd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxIaW1hd2FyaSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTh8MA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
6346	4384	7.72	http://www.imoesiq.top/KiYeNOH	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEl0YWxpYW5vJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
9697	4476	7.01	https://ufjtrtz.com/ehBrTbT.html	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMEhhd2FpaWFuJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwMDYwNzN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Hawaiian
159	4476	3.57	http://psygsow.com/DlyyYwp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1456324463128-7ff6903988d8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8U2FpbnQlMjBGcmFuayUyMENvZmZlZSUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyN3ww&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
4719	4476	5.69	https://wpcvepg.ru/OvtgeYM.svg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1569761316261-9a8696fa2ca3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMHx8VW5hZ2klMjBQaGlsYWRlbHBoaWElMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjA4OTYxN3ww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
8561	4476	5.21	http://wtxsvxn.com/ItFxHsN.jpg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1472393365320-db77a5abbecc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8UGl6emElMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MTJ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza
9947	4476	5.37	http://www.cqwuxmj.ru/WAFGIqS	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1653249288113-ed6e0db195a3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxCZWFuJTIwR3JlZW4lMjBDaGlsaSUyMEJ1cnJpdG9zJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwMDU1NzZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
3015	4476	2.58	https://yuypjld.edu/PDpPVcC.css	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1611143669185-af224c5e3252?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxHcmFwZSUyMEplbGx5JTIwU2FuZHdpY2glMjBzdXNoaXxlbnwwfHx8fDE3MjYwMDU1Nzd8MA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
9556	4476	5.73	http://nhoiuyr.biz/gnJWapi.html	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
2556	4476	4.88	http://drmuvia.biz/AvUmOlc.html	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1543255006-d6395b6f1171?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxTd2VldCUyMFBvdGF0byUyMFBpZSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDc0fDA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
3639	4476	7.09	http://whhntwv.org/HGfniMJ.jpg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1543255006-d6395b6f1171?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxTd2VldCUyMFBvdGF0byUyMFBpZSUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDc0fDA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
8578	4476	4.39	http://tekamlk.biz/qMMyOVt.css	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxQaXp6YSUyMEZsb3JpZGElMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjB8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
7587	4476	4.2	http://aoqvuxs.biz/IQVyadW.php	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098912-8b2b44fde4d6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxDaGlja2VuJTIwUG90JTIwUGllJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
2420	4476	5.79	http://oaovumt.edu/jFkCdxC.css	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8QmFjb24lMjBDaGVlc2UlMjBCdXJnZXIlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2Mjd8MA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
6338	4476	3.32	http://sktepuf.com/xdmONkC.svg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1608220874995-aa3e5301c676?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGhpbGFkZWxwaGlhJTIwd2l0aCUyMHNhbG1vbiUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3N3ww&ixlib=rb-4.0.3&q=80&w=1080	Philadelphia with salmon
5606	4476	5.48	http://wckiivm.net/PrDvXnA.svg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1472393365320-db77a5abbecc?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8UGl6emElMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MTJ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza
8044	4476	7.78	https://www.jbrvefb.com/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxTd2VkaXNoJTIwTWVhdGJhbGxzJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA1NTc4fDA&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
4309	4476	6.72	http://xjtjblb.top/hCuHrDS.css	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxCYWNvbiUyMENoZWVzZSUyMEJ1cmdlciUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjIxfDA&ixlib=rb-4.0.3&q=80&w=1080	Bacon Cheese Burger
899	4476	3.07	https://jirdiwi.edu/bpZOqej.webp	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1530554764233-e79e16c91d08?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxXYWxsbWFydCUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTV8MA&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
3402	4476	4.61	http://www.pwysqxc.edu/cHqugIB	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8UGl6emElMjBPY2VhbiUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
2941	4476	5.38	http://qnbojiu.ru/qtjApDn.php	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1521401292936-0a2129a30b1c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxTYWludCUyMEZyYW5rJTIwQ29mZmVlJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDA1NTgyfDA&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
6636	4476	3.07	https://www.gwxksvs.org/	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGl6emElMjBGbG9yaWRhJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
3461	4476	3.34	https://iiyffrq.info/vgjxSZd.webp	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1631214499883-47ef353c0372?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8VW5hZ2klMjBQaGlsYWRlbHBoaWElMjBidXJnZXJ8ZW58MHx8fHwxNzI2MDA1NTgxfDA&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
1043	4476	6.65	https://www.iskskep.net/	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600628421066-f6bda6a7b976?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8R3JhcGUlMjBKZWxseSUyMFNhbmR3aWNoJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDc1fDA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
7917	4476	4.95	http://dehxird.org/qfQHVNJ.css	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1611143669185-af224c5e3252?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxHcmFwZSUyMEplbGx5JTIwU2FuZHdpY2glMjBzdXNoaXxlbnwwfHx8fDE3MjYwMDU1Nzd8MA&ixlib=rb-4.0.3&q=80&w=1080	Grape Jelly Sandwich
8100	4476	4.32	https://vccgofb.edu/QvaUvsm.jpg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1520072959219-c595dc870360?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8VW53cmFwcGVkJTIwQnVycml0byUyMEJvd2wlMjBidXJnZXJ8ZW58MHx8fHwxNzI2MDg5NjI4fDA&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
3829	4476	7.85	https://yaghekm.info/pBEoRKi.svg	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1670338512239-556181fff224?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxMXx8UGl6emElMjBkZXNzZXJ0fGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Pizza
6647	4476	7.7	https://uvimaph.info/AGXLfDE.svg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607246749144-7bc0e401623c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxVbmFnaSUyMFBoaWxhZGVscGhpYSUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA2OHww&ixlib=rb-4.0.3&q=80&w=1080	Unagi Philadelphia
4730	4476	4.78	https://apcdifk.top/sryhsbM	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1517686469429-8bdb88b9f907?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGl6emElMjBGbG9yaWRhJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Florida
1422	185	7.45	http://fjvpelt.edu/wWTJCfJ.svg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1571997478779-2adcbbe9ab2f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwzfHxPcmlnaW5hbCUyMGJ1cmdlciUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3NHww&ixlib=rb-4.0.3&q=80&w=1080	Original burger
78	185	4.98	https://uhtoipa.info/momGsFd.webp	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxPcmlnaW5hbCUyMGJ1cmdlciUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDA2MDczfDA&ixlib=rb-4.0.3&q=80&w=1080	Original burger
4490	185	2.87	http://nycimff.ru/RurMuuZ.jpg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600628421055-4d30de868b8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGVhbnV0JTIwQnV0dGVyJTIwcGl6emF8ZW58MHx8fHwxNzI2MDg5NjEyfDA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
5393	185	5.19	http://heohbpf.biz/CWSFFIu.html	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxTd2VkaXNoJTIwTWVhdGJhbGxzJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA1NTc4fDA&ixlib=rb-4.0.3&q=80&w=1080	Swedish Meatballs
5276	185	6.13	https://jbfoimp.edu/hFoqOQC.webp	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607246749144-7bc0e401623c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxPcmlnaW5hbCUyMGJ1cmdlciUyMHN1c2hpfGVufDB8fHx8MTcyNjA4OTYxNnww&ixlib=rb-4.0.3&q=80&w=1080	Original burger
8003	185	6.98	http://xqipstn.ru/CNDvmvm.php	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxUb3J0ZWxsaW5pJTIwQm93bHMlMjBwaXp6YXxlbnwwfHx8fDE3MjYwMDYwNzN8MA&ixlib=rb-4.0.3&q=80&w=1080	Tortellini Bowls
5337	185	6.13	http://aocdosq.net/lgEoGZh.jpg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1601332069884-15a8149df78a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNXx8UGhpbGFkZWxwaGlhJTIwd2l0aCUyMHNhbG1vbiUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2Mjh8MA&ixlib=rb-4.0.3&q=80&w=1080	Philadelphia with salmon
3370	185	4.04	http://ubcfghy.net/NfmfYwf.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1456324463128-7ff6903988d8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8U2FpbnQlMjBGcmFuayUyMENvZmZlZSUyMHBpenphfGVufDB8fHx8MTcyNjA4OTYyN3ww&ixlib=rb-4.0.3&q=80&w=1080	Saint Frank Coffee
9146	185	7.92	http://ugaorrj.biz/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1485921198582-a55119c97421?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8QW5nZWwlMjBGb29kJTIwQ2FrZSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDYwNzN8MA&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
149	185	5.89	https://xkiacyz.top/ETgjoXx.js	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxXYWxsbWFydCUyMHN1c2hpfGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
7106	185	6.43	http://kfdfqpj.ru/pKRSDlx.svg	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1600628421055-4d30de868b8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGVhbnV0JTIwQnV0dGVyJTIwcGl6emF8ZW58MHx8fHwxNzI2MDg5NjEyfDA&ixlib=rb-4.0.3&q=80&w=1080	Peanut Butter
1793	185	2.19	http://myzogoj.net/gCMvRbH	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyME9jZWFuJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjE4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
3377	185	3.5	http://obvewqs.biz/eVhLpOd.php	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1531722596216-1fb4fbace9b7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxOZXclMjBZb3JrJTIwU3R5bGUlMjBDaGVlc2VjYWtlJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjE0fDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
3944	185	7.11	http://bqopbnm.biz/vZAcFlF.css	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxNHx8U3dlZXQlMjBQb3RhdG8lMjBQaWUlMjBzdXNoaXxlbnwwfHx8fDE3MjYwODk2MjZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Sweet Potato Pie
457	185	5.51	https://drgrzsc.biz/fRqRZVQ.svg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1511378156040-1259b5bcd0fb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxfHxVbndyYXBwZWQlMjBCdXJyaXRvJTIwQm93bCUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA2OXww&ixlib=rb-4.0.3&q=80&w=1080	Unwrapped Burrito Bowl
9788	185	6.4	http://xsuqhux.info/nvJSigK.svg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1529139574466-a303027c1d8b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8TmV3JTIwWW9yayUyMFN0eWxlJTIwQ2hlZXNlY2FrZSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MjJ8MA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
6192	185	6.64	https://vdlmuka.org/MPNOirv.svg	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1531722596216-1fb4fbace9b7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxOZXclMjBZb3JrJTIwU3R5bGUlMjBDaGVlc2VjYWtlJTIwZnJvemVuX21lYWx8ZW58MHx8fHwxNzI2MDg5NjE0fDA&ixlib=rb-4.0.3&q=80&w=1080	New York Style Cheesecake
3430	185	7.44	https://www.ebucicq.com/nIoWkNN	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1555072956-7758afb20e8f?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxM3x8UGl6emElMjBPY2VhbiUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3MXww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
2438	185	3.85	http://eydkqtn.com/UTSPcMQ	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/31/RpgvvtYAQeqAIs1knERU_vegetables.jpg?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxN3x8QW5nZWwlMjBGb29kJTIwQ2FrZSUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA3NXww&ixlib=rb-4.0.3&q=80&w=1080	Angel Food Cake
6183	185	4.6	http://www.iwhfozb.com/sIORWVd	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1608220874995-aa3e5301c676?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGhpbGFkZWxwaGlhJTIwd2l0aCUyMHNhbG1vbiUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3N3ww&ixlib=rb-4.0.3&q=80&w=1080	Philadelphia with salmon
4982	185	5.48	http://uexrilp.net/ndJtsqB.svg	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1589187151053-5ec8818e661b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTN8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
4067	185	6.32	https://rztnxrg.org/PBAaGgH.webp	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1653249288113-ed6e0db195a3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw1fHxCZWFuJTIwR3JlZW4lMjBDaGlsaSUyMEJ1cnJpdG9zJTIwZGVzc2VydHxlbnwwfHx8fDE3MjYwMDU1NzZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Bean Green Chili Burritos
9109	185	4.31	http://jyxqjqu.biz/JDrmltc.webp	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1608220874995-aa3e5301c676?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGhpbGFkZWxwaGlhJTIwd2l0aCUyMHNhbG1vbiUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjAwNjA3N3ww&ixlib=rb-4.0.3&q=80&w=1080	Philadelphia with salmon
6282	185	5.11	https://nzvjjoe.top/	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1568901346375-23c9450c58cd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw2fHxIaW1hd2FyaSUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwODk2MTh8MA&ixlib=rb-4.0.3&q=80&w=1080	Himawari
2572	185	3.09	https://tboajmp.ru/hMnIsMD	3e2bc231-5b10-4630-970b-dcb4dedc719d	\N	https://images.unsplash.com/photo-1604186838309-c6715f0d3e6c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwyfHxXYWxsbWFydCUyMGZyb3plbl9tZWFsfGVufDB8fHx8MTcyNjA4OTYxOXww&ixlib=rb-4.0.3&q=80&w=1080	Wallmart
6455	185	2.46	http://etmwrcb.net/GFVAPuq.php	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1489564239502-7a532064e1c2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw5fHxQaXp6YSUyMEl0YWxpYW5vJTIwcGl6emF8ZW58MHx8fHwxNzI2MDA2MDY4fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Italiano
4761	185	2.8	http://lkiwuxo.org/SYnjWBQ	ed21c4cf-4d54-433f-a9fa-5301a3672791	\N	https://images.unsplash.com/photo-1510297895683-0f27794412d5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHwxOXx8UGl6emElMjBPY2VhbiUyMGJ1cmdlcnxlbnwwfHx8fDE3MjYwMDU1NzZ8MA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Ocean
3580	185	5.15	https://wmtivlw.biz/	1a581b8e-5a8e-45e4-ab99-a68f62f5eb6b	\N	https://images.unsplash.com/photo-1600028068383-ea11a7a101f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw4fHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMGRlc3NlcnR8ZW58MHx8fHwxNzI2MDg5NjI2fDA&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
2390	185	5.61	https://rfynhwj.edu/ibUflSc.jpg	8c9df06e-f840-42ae-ad2f-e08af1ab330f	\N	https://images.unsplash.com/photo-1607247098912-8b2b44fde4d6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw0fHxDaGlja2VuJTIwUG90JTIwUGllJTIwc3VzaGl8ZW58MHx8fHwxNzI2MDg5NjMxfDA&ixlib=rb-4.0.3&q=80&w=1080	Chicken Pot Pie
1	1	6.49	https://roll-club.kh.ua/wp-content/uploads/2021/04/okean-1.jpg.webp	4488fc9d-c634-4641-9507-4e9baaa94bee	\N	https://images.unsplash.com/photo-1706954225234-fe9808ce3d72?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w2NTI0NDh8MHwxfHNlYXJjaHw3fHxQaXp6YSUyMFBlcHBlcm9uaSUyMHdpdGglMjB0b21hdG9lcyUyMHBpenphfGVufDB8fHx8MTcyNjAwNjA2Nnww&ixlib=rb-4.0.3&q=80&w=1080	Pizza Pepperoni with tomatoes
\.


--
-- Data for Name: stores; Type: TABLE DATA; Schema: public; Owner: doadmin
--

COPY public.stores (id, uid, name, "profilePicture", "createdAt", "updatedAt", type) FROM stdin;
3	6de355b5-aada-4fcf-ab85-2b01536d9c21	Saint Frank Coffee	http://cdn.shopify.com/s/files/1/1578/1589/files/colorf-01_198x200.png	15:06:56.498815	15:06:56.498815	coffee_shop
4	976ec0ec-e9d6-45c9-983f-aa7886318787	Sushi Space	https://image.freepik.com/free-vector/sushi-restaurant-logo_8169-12.jpg	15:06:56.509949	15:06:56.509949	restaurant
7	9be66eb1-3e22-4d1d-b7c5-9ecee786a4e4	Linea Caffe	https://lineacaffe.com/wp-content/themes/lineacaffe/images/linea-logo.svg	15:06:56.535713	15:06:56.535713	coffee_shop
5509	e246b133-e5a8-40a8-9700-722b294ad5ed	Gastro Green	http://www.gastromanager.hu/sites/default/files/gastrogreens_logo_low.jpg	15:06:56.544118	15:06:56.544118	bar
134	1ae4924d-ad53-4d16-ac8c-922cc19e0119	ATB	http://www.kharkovinfo.com/previews/atb.png	15:06:56.552689	15:06:56.552689	supermarket
3763	6de355b5-aada-4fcf-ab85-2b01536d9c21	Saint Frank Coffee	https://media.licdn.com/dms/image/v2/C560BAQHoBrs1ERWhcA/company-logo_200_200/company-logo_200_200/0/1630650704189/saint_frank_coffee_logo?e=2147483647&v=beta&t=A5L-bWebEEsHKhFLl9qipmQIJZARCq4ml1jeKo8cZfM	15:06:56.560219	15:06:56.56022	restaurant
4301	6de355b5-aada-4fcf-ab85-2b01536d9c21	Saint Frank Coffee	https://media.licdn.com/dms/image/v2/C560BAQHoBrs1ERWhcA/company-logo_200_200/company-logo_200_200/0/1630650704189/saint_frank_coffee_logo?e=2147483647&v=beta&t=A5L-bWebEEsHKhFLl9qipmQIJZARCq4ml1jeKo8cZfM	15:06:56.566792	15:06:56.566792	bar
1679	8e8b03f7-5993-415c-ad5b-284e7f82ac0b	Sushia	https://sushia.fr/image/customer/sushia_fr/deco/2.png	15:06:56.573473	15:06:56.573473	sushi_shop
4867	9702f13d-82bf-4658-8e08-12f45182152c	Pizza Club	https://play-lh.googleusercontent.com/qMewibe3u5Wvq3fBf3Ca3_QItjHCOKeGrOAzVXWxqzgRpMwxYlD5CA6M2M5L78SwNA	15:06:56.579949	15:06:56.579949	supermarket
1352	3e5806bd-5d4c-4bfb-8cfd-ea62927a2e2b	Bistro	https://logopond.com/logos/936fb12d35d4bb7f4f9d6c3085caa4e4.png	15:06:56.586065	15:06:56.586066	shop
1103	9702f13d-82bf-4658-8e08-12f45182152c	Pizza Club	https://play-lh.googleusercontent.com/qMewibe3u5Wvq3fBf3Ca3_QItjHCOKeGrOAzVXWxqzgRpMwxYlD5CA6M2M5L78SwNA	15:06:56.592261	15:06:56.592261	coffee_shop
417	6de355b5-aada-4fcf-ab85-2b01536d9c21	Saint Frank Coffee	http://cdn.shopify.com/s/files/1/1578/1589/files/colorf-01_198x200.png	15:06:56.604695	15:06:56.604695	restaurant
4384	1ae4924d-ad53-4d16-ac8c-922cc19e0119	ATB	http://www.kharkovinfo.com/previews/atb.png	15:06:56.611194	15:06:56.611194	supermarket
4476	976ec0ec-e9d6-45c9-983f-aa7886318787	Sushi Space	https://image.freepik.com/free-vector/sushi-restaurant-logo_8169-12.jpg	15:06:56.617343	15:06:56.617343	restaurant
185	e246b133-e5a8-40a8-9700-722b294ad5ed	Gastro Green	http://www.gastromanager.hu/sites/default/files/gastrogreens_logo_low.jpg	15:06:56.623635	15:06:56.623635	restaurant
2	6fb3a4ca-ea04-466a-91a3-a3237f7b6b4f	Burger Club	https://images.unsplash.com/photo-1565607569011-577f0785694f?q=80&w=2365&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D	15:06:56.48737	15:06:56.48737	restaurant
2965	6fb3a4ca-ea04-466a-91a3-a3237f7b6b4f	Burger Club	https://images.unsplash.com/photo-1565607569011-577f0785694f?q=80&w=2365&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D	15:06:56.598245	15:06:56.598245	restaurant
5	b25c92a4-9b3f-4a78-a562-2feeeae13cbf	Target	https://1000logos.net/wp-content/uploads/2017/06/Target-logo-1.png	15:06:56.520796	15:06:56.520797	supermarket
6	89fcb58c-d1b7-4ba1-8afa-dad62cf76127	Wallmart	https://media.bio.site/sites/cfa9f667-9249-431c-ba6b-606dfad55571/2JHDxCnUMnyCQQ5gX9NtzJ.png	15:06:56.528721	15:06:56.528721	supermarket
1	9702f13d-82bf-4658-8e08-12f45182152c	Pizza Club	https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzL0C49NDgxrw-4OK_cKSiS_CauHUSgyIpIA&s	15:06:56.467125	15:06:56.467125	restaurant
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: doadmin
--

COPY public.users (id, email, password, "firstName", "lastName", "userName", "displayName", deleted, "phoneNumber", "profilePicture", role, "createdAt", "updatedAt") FROM stdin;
7ca906b5-d61f-4ded-9987-500bc3696692	test@test.com	$2a$14$Gn6MLqc0MSp3XECb/oVQ2.8/ypqH3cde5O/37SggIVYO7kCiES/DS	test	test	testist	test test	f		https://i.pinimg.com/564x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg	customer	01:03:05.012958	01:03:05.012959
9702f13d-82bf-4658-8e08-12f45182152c	pizzaclub@test.com	$2a$10$E990LMY9gEmPDANz/O1bp.AWs08f6w20ourDEHnIeQ0z2tGX3hn5a	Pizza	Club	pizzaclub	Pizza Club	f		https://i.pinimg.com/564x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg	store	13:43:35.942049	13:43:35.94205
6fb3a4ca-ea04-466a-91a3-a3237f7b6b4f	burgerclub@test.com	$2a$10$ADkEnUrT.BVS4sxMhZn8fuJSBQHurBsnmeQ11Fqq/fOGqTnmY6hR6	Burger	Club	burgerclub	Burger Club	f		https://i.pinimg.com/564x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg	store	13:43:35.944736	13:43:35.944736
6de355b5-aada-4fcf-ab85-2b01536d9c21	saintcoffee@test.com	$2a$10$beB4/YFZdfPFok1qShfiBO35qTIskkWGTM8.oiy/zoeCWOVcSKNHq	Saint	Coffee	saintcoffee	Saint Frank Coffee	f		https://i.pinimg.com/564x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg	store	13:43:35.945914	13:43:35.945914
976ec0ec-e9d6-45c9-983f-aa7886318787	sushispace@test.com	$2a$10$sKpBn1LCZAhLUQXPC7I2X.zMawlhsngMlPjU2sPD9aB38gTJggkOy	Sushi	Space	sushispace	Sushi Space	f		https://i.pinimg.com/564x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg	store	13:43:35.946928	13:43:35.946928
b25c92a4-9b3f-4a78-a562-2feeeae13cbf	targetsupermarket@test.com	$2a$10$HYbDPM9qoafxae4aUvoEo.P7bwsslOi1njpPtcPXK8i6dsGpqxiDy	Target	supermarket	targetsupermarket	Target supermarket	f		https://i.pinimg.com/564x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg	store	13:43:35.949641	13:43:35.949641
89fcb58c-d1b7-4ba1-8afa-dad62cf76127	wallmartsupermarket@test.com	$2a$10$KVNRyoFp0C8Q5Qz/dYSsPOu5NJcWAuMN2xw23ERj9K38CP0buLMkW	Wallmart	supermarket	wallmartsupermarket	Wallmart supermarket	f		https://i.pinimg.com/564x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg	store	13:43:35.951159	13:43:35.951159
9be66eb1-3e22-4d1d-b7c5-9ecee786a4e4	lineacaffe@test.com	$2a$10$U2osoqFHMBX8S8DVlSElzeweDIIfFQ2PWuGXpoEhtIvPxjj47Ckjy	Linea	Caffe	lineacaffe	Linea Caffe	f		https://i.pinimg.com/564x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg	store	13:43:35.95248	13:43:35.95248
e246b133-e5a8-40a8-9700-722b294ad5ed	gastrogreen@test.com	$2a$10$9t6fel.ZIkAEeOq7k63KUu0o2eodu2x2UML1QinEKYacOjXloENLG	Gastro	Green	gastrogreen	Gastro Green	f		https://i.pinimg.com/564x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg	store	13:43:35.953444	13:43:35.953444
1ae4924d-ad53-4d16-ac8c-922cc19e0119	atbsupermarket@test.com	$2a$10$0gNFi2u3cZbS6w.6DDF7FuujsXUynZHoJVJG1//TyzQV6IPBqbtie	ATB	supermarket	atbsupermarket	ATB supermarket	f		https://i.pinimg.com/564x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg	store	13:43:35.954491	13:43:35.954491
8e8b03f7-5993-415c-ad5b-284e7f82ac0b	sushiasushi_shop@test.com	$2a$10$l5ncHCU6ystg/3dwRC4yTO2KRYwugGV9bxkviM/eadk4x6LRhhcu6	Sushia	sushi_shop	sushiasushi_shop	Sushia sushi_shop	f		https://i.pinimg.com/564x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg	store	13:43:35.956433	13:43:35.956433
3e5806bd-5d4c-4bfb-8cfd-ea62927a2e2b	bistroshop@test.com	$2a$10$l2srqXc.ybh30QIrqZ6eMu0W/r9.8acyVSMbd7/TGi4xn4Mhd.cAy	Bistro	shop	bistroshop	Bistro shop	f		https://i.pinimg.com/564x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg	store	13:43:35.958004	13:43:35.958004
55519ba4-342a-4574-956e-f0af1b428970	bryangichuru@gmail.com	$2a$14$Vw6WNPaxGvdoVFILHINTtehAC0FhzKPpzEAUPrYh7Z6U1G/vSoQmO	BRYAN	GICHURU	bryanwilliam	BRYAN GICHURU	f		https://i.pinimg.com/564x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg	customer	04:52:27.917721	04:52:27.917721
\.


--
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doadmin
--

SELECT pg_catalog.setval('public.addresses_id_seq', 2, true);


--
-- Name: ingredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doadmin
--

SELECT pg_catalog.setval('public.ingredients_id_seq', 40, true);


--
-- Name: likes_postId_seq; Type: SEQUENCE SET; Schema: public; Owner: doadmin
--

SELECT pg_catalog.setval('public."likes_postId_seq"', 1, false);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doadmin
--

SELECT pg_catalog.setval('public.order_items_id_seq', 3, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doadmin
--

SELECT pg_catalog.setval('public.orders_id_seq', 8, true);


--
-- Name: stores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doadmin
--

SELECT pg_catalog.setval('public.stores_id_seq', 1, false);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: ingredients ingredients_name_key; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_name_key UNIQUE (name);


--
-- Name: ingredients ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_pkey PRIMARY KEY (id);


--
-- Name: likes likes_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: post_categories post_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.post_categories
    ADD CONSTRAINT post_categories_pkey PRIMARY KEY ("postId", "categoryId");


--
-- Name: post_ingredients post_ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.post_ingredients
    ADD CONSTRAINT post_ingredients_pkey PRIMARY KEY ("postId", ingredient_id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: stores stores_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (id);


--
-- Name: users unique_email; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_email UNIQUE (email);


--
-- Name: likes unique_like; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT unique_like UNIQUE ("postId", uid);


--
-- Name: users unique_username; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_username UNIQUE ("userName");


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: addresses addresses_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_uid_fkey FOREIGN KEY (uid) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: likes likes_postId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT "likes_postId_fkey" FOREIGN KEY ("postId") REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: likes likes_postId_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT "likes_postId_fkey1" FOREIGN KEY ("postId") REFERENCES public.posts(id);


--
-- Name: likes likes_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_uid_fkey FOREIGN KEY (uid) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: likes likes_uid_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_uid_fkey1 FOREIGN KEY (uid) REFERENCES public.users(id);


--
-- Name: order_items order_items_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT "order_items_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_store_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_store_fkey FOREIGN KEY (store) REFERENCES public.stores(id) ON DELETE CASCADE;


--
-- Name: orders orders_addressId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT "orders_addressId_fkey" FOREIGN KEY ("addressId") REFERENCES public.addresses(id) ON DELETE CASCADE;


--
-- Name: orders orders_storeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT "orders_storeId_fkey" FOREIGN KEY ("storeId") REFERENCES public.stores(id) ON DELETE CASCADE;


--
-- Name: orders orders_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_uid_fkey FOREIGN KEY (uid) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: post_categories post_categories_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.post_categories
    ADD CONSTRAINT "post_categories_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: post_categories post_categories_postId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.post_categories
    ADD CONSTRAINT "post_categories_postId_fkey" FOREIGN KEY ("postId") REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: post_ingredients post_ingredients_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.post_ingredients
    ADD CONSTRAINT post_ingredients_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES public.ingredients(id) ON DELETE CASCADE;


--
-- Name: post_ingredients post_ingredients_postId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.post_ingredients
    ADD CONSTRAINT "post_ingredients_postId_fkey" FOREIGN KEY ("postId") REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: posts posts_store_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_store_fkey FOREIGN KEY (store) REFERENCES public.stores(id) ON DELETE CASCADE;


--
-- Name: posts posts_store_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_store_fkey1 FOREIGN KEY (store) REFERENCES public.stores(id);


--
-- Name: posts posts_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_type_fkey FOREIGN KEY (type) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: posts posts_type_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_type_fkey1 FOREIGN KEY (type) REFERENCES public.categories(id);


--
-- Name: stores stores_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doadmin
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_uid_fkey FOREIGN KEY (uid) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: TABLE addresses; Type: ACL; Schema: public; Owner: doadmin
--

GRANT ALL ON TABLE public.addresses TO goserver;


--
-- Name: SEQUENCE addresses_id_seq; Type: ACL; Schema: public; Owner: doadmin
--

GRANT SELECT,USAGE ON SEQUENCE public.addresses_id_seq TO goserver;


--
-- Name: TABLE categories; Type: ACL; Schema: public; Owner: doadmin
--

GRANT ALL ON TABLE public.categories TO goserver;


--
-- Name: TABLE ingredients; Type: ACL; Schema: public; Owner: doadmin
--

GRANT ALL ON TABLE public.ingredients TO goserver;


--
-- Name: SEQUENCE ingredients_id_seq; Type: ACL; Schema: public; Owner: doadmin
--

GRANT SELECT,USAGE ON SEQUENCE public.ingredients_id_seq TO goserver;


--
-- Name: TABLE likes; Type: ACL; Schema: public; Owner: doadmin
--

GRANT ALL ON TABLE public.likes TO goserver;


--
-- Name: SEQUENCE "likes_postId_seq"; Type: ACL; Schema: public; Owner: doadmin
--

GRANT SELECT,USAGE ON SEQUENCE public."likes_postId_seq" TO goserver;


--
-- Name: TABLE order_items; Type: ACL; Schema: public; Owner: doadmin
--

GRANT ALL ON TABLE public.order_items TO goserver;


--
-- Name: SEQUENCE order_items_id_seq; Type: ACL; Schema: public; Owner: doadmin
--

GRANT SELECT,USAGE ON SEQUENCE public.order_items_id_seq TO goserver;


--
-- Name: TABLE orders; Type: ACL; Schema: public; Owner: doadmin
--

GRANT ALL ON TABLE public.orders TO goserver;


--
-- Name: SEQUENCE orders_id_seq; Type: ACL; Schema: public; Owner: doadmin
--

GRANT SELECT,USAGE ON SEQUENCE public.orders_id_seq TO goserver;


--
-- Name: TABLE post_categories; Type: ACL; Schema: public; Owner: doadmin
--

GRANT ALL ON TABLE public.post_categories TO goserver;


--
-- Name: TABLE post_ingredients; Type: ACL; Schema: public; Owner: doadmin
--

GRANT ALL ON TABLE public.post_ingredients TO goserver;


--
-- Name: TABLE posts; Type: ACL; Schema: public; Owner: doadmin
--

GRANT ALL ON TABLE public.posts TO goserver;


--
-- Name: TABLE stores; Type: ACL; Schema: public; Owner: doadmin
--

GRANT ALL ON TABLE public.stores TO goserver;


--
-- Name: SEQUENCE stores_id_seq; Type: ACL; Schema: public; Owner: doadmin
--

GRANT SELECT,USAGE ON SEQUENCE public.stores_id_seq TO goserver;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: doadmin
--

GRANT ALL ON TABLE public.users TO goserver;


--
-- PostgreSQL database dump complete
--

