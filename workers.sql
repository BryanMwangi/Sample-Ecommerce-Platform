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
-- Name: working_hours; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.working_hours (
    id integer NOT NULL,
    "storeId" integer,
    opening time without time zone NOT NULL,
    closing time without time zone NOT NULL,
    day text NOT NULL,
    "isOpen" boolean NOT NULL
);


ALTER TABLE public.working_hours OWNER TO postgres;

--
-- Name: workingHours_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."workingHours_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."workingHours_id_seq" OWNER TO postgres;

--
-- Name: workingHours_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."workingHours_id_seq" OWNED BY public.working_hours.id;


--
-- Name: working_hours id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.working_hours ALTER COLUMN id SET DEFAULT nextval('public."workingHours_id_seq"'::regclass);


--
-- Data for Name: working_hours; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.working_hours (id, "storeId", opening, closing, day, "isOpen") FROM stdin;
1	1	09:00:00	20:00:00	Monday	t
2	1	09:00:00	20:00:00	Tuesday	t
3	1	09:00:00	20:00:00	Wednesday	t
4	1	09:00:00	20:00:00	Thursday	t
5	1	09:00:00	20:00:00	Friday	t
6	1	09:00:00	20:00:00	Saturday	t
7	1	09:00:00	20:00:00	Sunday	t
8	2	10:00:00	20:00:00	Monday	t
9	2	10:00:00	20:00:00	Tuesday	t
10	2	10:00:00	20:00:00	Wednesday	t
11	2	10:00:00	20:00:00	Thursday	t
12	2	10:00:00	20:00:00	Friday	t
13	2	10:00:00	20:00:00	Saturday	t
14	2	10:00:00	20:00:00	Sunday	t
15	3	12:00:00	18:00:00	Monday	t
16	3	12:00:00	18:00:00	Tuesday	t
17	3	12:00:00	18:00:00	Wednesday	t
18	3	12:00:00	18:00:00	Thursday	t
19	3	12:00:00	18:00:00	Friday	t
20	3	12:00:00	18:00:00	Saturday	t
21	3	12:00:00	18:00:00	Sunday	t
22	4	08:00:00	20:00:00	Monday	t
23	4	08:00:00	20:00:00	Tuesday	t
24	4	08:00:00	20:00:00	Wednesday	t
25	4	08:00:00	20:00:00	Thursday	t
26	4	08:00:00	20:00:00	Friday	t
27	4	08:00:00	20:00:00	Saturday	t
28	4	08:00:00	20:00:00	Sunday	t
29	5	00:00:00	24:00:00	Monday	t
30	5	00:00:00	24:00:00	Tuesday	t
31	5	00:00:00	24:00:00	Wednesday	t
32	5	00:00:00	24:00:00	Thursday	t
33	5	00:00:00	24:00:00	Friday	t
34	5	00:00:00	24:00:00	Saturday	t
35	5	00:00:00	24:00:00	Sunday	t
36	6	00:00:00	24:00:00	Monday	t
37	6	00:00:00	24:00:00	Tuesday	t
38	6	00:00:00	24:00:00	Wednesday	t
39	6	00:00:00	24:00:00	Thursday	t
40	6	00:00:00	24:00:00	Friday	t
41	6	00:00:00	24:00:00	Saturday	t
42	6	00:00:00	24:00:00	Sunday	t
43	7	07:00:00	19:00:00	Monday	t
44	7	07:00:00	19:00:00	Tuesday	t
45	7	07:00:00	19:00:00	Wednesday	t
46	7	07:00:00	19:00:00	Thursday	t
47	7	07:00:00	19:00:00	Friday	t
48	7	07:00:00	19:00:00	Saturday	t
49	7	07:00:00	19:00:00	Sunday	t
50	5509	07:30:00	20:00:00	Monday	t
51	5509	07:30:00	20:00:00	Tuesday	t
52	5509	07:30:00	20:00:00	Wednesday	t
53	5509	07:30:00	20:00:00	Thursday	t
54	5509	07:30:00	20:00:00	Friday	t
55	5509	07:30:00	20:00:00	Saturday	t
56	5509	07:30:00	20:00:00	Sunday	t
57	134	10:00:00	20:00:00	Monday	t
58	134	10:00:00	20:00:00	Tuesday	t
59	134	10:00:00	20:00:00	Wednesday	t
60	134	10:00:00	20:00:00	Thursday	t
61	134	10:00:00	20:00:00	Friday	t
62	134	10:00:00	20:00:00	Saturday	t
63	134	10:00:00	20:00:00	Sunday	t
64	3763	08:00:00	17:00:00	Monday	t
65	3763	08:00:00	17:00:00	Tuesday	t
66	3763	08:00:00	17:00:00	Wednesday	t
67	3763	08:00:00	17:00:00	Thursday	t
68	3763	08:00:00	17:00:00	Friday	t
69	3763	08:00:00	17:00:00	Saturday	t
70	3763	08:00:00	17:00:00	Sunday	t
71	4301	10:30:00	19:30:00	Monday	t
72	4301	10:30:00	19:30:00	Tuesday	t
73	4301	10:30:00	19:30:00	Wednesday	t
74	4301	10:30:00	19:30:00	Thursday	t
75	4301	10:30:00	19:30:00	Friday	t
76	4301	10:30:00	19:30:00	Saturday	t
77	4301	10:30:00	19:30:00	Sunday	t
78	1679	08:00:00	18:00:00	Monday	t
79	1679	08:00:00	18:00:00	Tuesday	t
80	1679	08:00:00	18:00:00	Wednesday	t
81	1679	08:00:00	18:00:00	Thursday	t
82	1679	08:00:00	18:00:00	Friday	t
83	1679	08:00:00	18:00:00	Saturday	t
84	1679	08:00:00	18:00:00	Sunday	t
85	4867	09:00:00	20:00:00	Monday	t
86	4867	09:00:00	20:00:00	Tuesday	t
87	4867	09:00:00	20:00:00	Wednesday	t
88	4867	09:00:00	20:00:00	Thursday	t
89	4867	09:00:00	20:00:00	Friday	t
90	4867	09:00:00	20:00:00	Saturday	t
91	4867	09:00:00	20:00:00	Sunday	t
92	1352	10:00:00	18:30:00	Monday	t
93	1352	10:00:00	18:30:00	Tuesday	t
94	1352	10:00:00	18:30:00	Wednesday	t
95	1352	10:00:00	18:30:00	Thursday	t
96	1352	10:00:00	18:30:00	Friday	t
97	1352	10:00:00	18:30:00	Saturday	t
98	1352	10:00:00	18:30:00	Sunday	t
99	1103	07:00:00	19:30:00	Monday	t
100	1103	07:00:00	19:30:00	Tuesday	t
101	1103	07:00:00	19:30:00	Wednesday	t
102	1103	07:00:00	19:30:00	Thursday	t
103	1103	07:00:00	19:30:00	Friday	t
104	1103	07:00:00	19:30:00	Saturday	t
105	1103	07:00:00	19:30:00	Sunday	t
106	2965	10:00:00	17:00:00	Monday	t
107	2965	10:00:00	17:00:00	Tuesday	t
108	2965	10:00:00	17:00:00	Wednesday	t
109	2965	10:00:00	17:00:00	Thursday	t
110	2965	10:00:00	17:00:00	Friday	t
111	2965	10:00:00	17:00:00	Saturday	t
112	2965	10:00:00	17:00:00	Sunday	t
113	417	07:00:00	19:30:00	Monday	t
114	417	07:00:00	19:30:00	Tuesday	t
115	417	07:00:00	19:30:00	Wednesday	t
116	417	07:00:00	19:30:00	Thursday	t
117	417	07:00:00	19:30:00	Friday	t
118	417	07:00:00	19:30:00	Saturday	t
119	417	07:00:00	19:30:00	Sunday	t
120	4384	07:00:00	20:00:00	Monday	t
121	4384	07:00:00	20:00:00	Tuesday	t
122	4384	07:00:00	20:00:00	Wednesday	t
123	4384	07:00:00	20:00:00	Thursday	t
124	4384	07:00:00	20:00:00	Friday	t
125	4384	07:00:00	20:00:00	Saturday	t
126	4384	07:00:00	20:00:00	Sunday	t
127	4476	10:00:00	20:00:00	Monday	t
128	4476	10:00:00	20:00:00	Tuesday	t
129	4476	10:00:00	20:00:00	Wednesday	t
130	4476	10:00:00	20:00:00	Thursday	t
131	4476	10:00:00	20:00:00	Friday	t
132	4476	10:00:00	20:00:00	Saturday	t
133	4476	10:00:00	20:00:00	Sunday	t
134	185	08:00:00	20:00:00	Monday	t
135	185	08:00:00	20:00:00	Tuesday	t
136	185	08:00:00	20:00:00	Wednesday	t
137	185	08:00:00	20:00:00	Thursday	t
138	185	08:00:00	20:00:00	Friday	t
139	185	08:00:00	20:00:00	Saturday	t
140	185	08:00:00	20:00:00	Sunday	t
\.


--
-- Name: workingHours_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."workingHours_id_seq"', 140, true);


--
-- Name: working_hours unique_store_day; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.working_hours
    ADD CONSTRAINT unique_store_day UNIQUE ("storeId", day);


--
-- Name: working_hours workingHours_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.working_hours
    ADD CONSTRAINT "workingHours_pkey" PRIMARY KEY (id);


--
-- Name: working_hours workingHours_storeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.working_hours
    ADD CONSTRAINT "workingHours_storeId_fkey" FOREIGN KEY ("storeId") REFERENCES public.stores(id) ON DELETE CASCADE;


--
-- Name: TABLE working_hours; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.working_hours TO goserver;


--
-- Name: SEQUENCE "workingHours_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public."workingHours_id_seq" TO goserver;


--
-- PostgreSQL database dump complete
--

