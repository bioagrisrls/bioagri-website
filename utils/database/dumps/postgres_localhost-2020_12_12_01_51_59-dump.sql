--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1 (Debian 13.1-1.pgdg100+1)
-- Dumped by pg_dump version 13.1

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

ALTER TABLE ONLY public.shop_wish DROP CONSTRAINT shop_wish_user_id_fkey;
ALTER TABLE ONLY public.shop_wish DROP CONSTRAINT shop_wish_product_id_fkey;
ALTER TABLE ONLY public.shop_transaction DROP CONSTRAINT shop_transaction_order_id_fkey;
ALTER TABLE ONLY public.shop_ticket DROP CONSTRAINT shop_ticket_user_id_fkey;
ALTER TABLE ONLY public.shop_ticket_response DROP CONSTRAINT shop_ticket_response_ticket_id_fkey;
ALTER TABLE ONLY public.shop_product_tag DROP CONSTRAINT shop_product_tag_product_id_fkey;
ALTER TABLE ONLY public.shop_product_tag DROP CONSTRAINT shop_product_tag_hashtag_id_fkey;
ALTER TABLE ONLY public.shop_product_category DROP CONSTRAINT shop_product_category_product_id_fkey;
ALTER TABLE ONLY public.shop_product_category DROP CONSTRAINT shop_product_category_category_id_fkey;
ALTER TABLE ONLY public.shop_order_product DROP CONSTRAINT shop_order_product_product_id_fkey;
ALTER TABLE ONLY public.shop_order_product DROP CONSTRAINT shop_order_product_order_id_fkey;
ALTER TABLE ONLY public.shop_feedback DROP CONSTRAINT shop_feedback_user_id_fkey;
ALTER TABLE ONLY public.shop_feedback DROP CONSTRAINT shop_feedback_product_id_fkey;
ALTER TABLE ONLY public.shop_category DROP CONSTRAINT shop_category_parent_id_fkey;
ALTER TABLE ONLY public.shop_wish DROP CONSTRAINT shop_wish_pkey;
ALTER TABLE ONLY public.shop_user DROP CONSTRAINT shop_user_pkey;
ALTER TABLE ONLY public.shop_user DROP CONSTRAINT shop_user_email_key;
ALTER TABLE ONLY public.shop_transaction DROP CONSTRAINT shop_transaction_pkey;
ALTER TABLE ONLY public.shop_ticket_response DROP CONSTRAINT shop_ticket_response_pkey;
ALTER TABLE ONLY public.shop_ticket DROP CONSTRAINT shop_ticket_pkey;
ALTER TABLE ONLY public.shop_tag DROP CONSTRAINT shop_tag_pkey;
ALTER TABLE ONLY public.shop_product_tag DROP CONSTRAINT shop_product_tag_pkey;
ALTER TABLE ONLY public.shop_product DROP CONSTRAINT shop_product_pkey;
ALTER TABLE ONLY public.shop_product_category DROP CONSTRAINT shop_product_category_pkey;
ALTER TABLE ONLY public.shop_order_product DROP CONSTRAINT shop_order_product_pkey;
ALTER TABLE ONLY public.shop_feedback DROP CONSTRAINT shop_feedback_pkey;
ALTER TABLE ONLY public.shop_category DROP CONSTRAINT shop_category_pkey;
ALTER TABLE ONLY public.shop_order DROP CONSTRAINT order_pkey;
ALTER TABLE public.shop_user ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.shop_transaction ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.shop_ticket_response ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.shop_ticket ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.shop_product ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.shop_order ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.shop_feedback ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.shop_category ALTER COLUMN id DROP DEFAULT;
DROP TABLE public.shop_wish;
DROP SEQUENCE public.shop_user_id_seq;
DROP TABLE public.shop_user;
DROP SEQUENCE public.shop_transaction_id_seq;
DROP TABLE public.shop_transaction;
DROP SEQUENCE public.shop_ticket_response_id_seq;
DROP TABLE public.shop_ticket_response;
DROP SEQUENCE public.shop_ticket_id_seq;
DROP TABLE public.shop_ticket;
DROP TABLE public.shop_tag;
DROP TABLE public.shop_product_tag;
DROP SEQUENCE public.shop_product_id_seq;
DROP TABLE public.shop_product_category;
DROP TABLE public.shop_product;
DROP TABLE public.shop_order_product;
DROP SEQUENCE public.shop_feedback_id_seq;
DROP TABLE public.shop_feedback;
DROP SEQUENCE public.shop_category_id_seq;
DROP TABLE public.shop_category;
DROP SEQUENCE public.order_id_seq;
DROP TABLE public.shop_order;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: shop_order; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.shop_order (
    id bigint NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.shop_order OWNER TO admin;

--
-- Name: order_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_id_seq OWNER TO admin;

--
-- Name: order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.order_id_seq OWNED BY public.shop_order.id;


--
-- Name: shop_category; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.shop_category (
    id bigint NOT NULL,
    parent_id bigint,
    name character varying(128) NOT NULL
);


ALTER TABLE public.shop_category OWNER TO admin;

--
-- Name: shop_category_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.shop_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_category_id_seq OWNER TO admin;

--
-- Name: shop_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.shop_category_id_seq OWNED BY public.shop_category.id;


--
-- Name: shop_feedback; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.shop_feedback (
    id bigint NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    vote real DEFAULT 0 NOT NULL,
    product_id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.shop_feedback OWNER TO admin;

--
-- Name: shop_feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.shop_feedback_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_feedback_id_seq OWNER TO admin;

--
-- Name: shop_feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.shop_feedback_id_seq OWNED BY public.shop_feedback.id;


--
-- Name: shop_order_product; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.shop_order_product (
    product_id bigint NOT NULL,
    order_id bigint NOT NULL,
    quantity integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.shop_order_product OWNER TO admin;

--
-- Name: shop_product; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.shop_product (
    id bigint NOT NULL,
    name character varying(256) NOT NULL,
    description text NOT NULL,
    price real DEFAULT 0 NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.shop_product OWNER TO admin;

--
-- Name: shop_product_category; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.shop_product_category (
    product_id bigint NOT NULL,
    category_id bigint NOT NULL
);


ALTER TABLE public.shop_product_category OWNER TO admin;

--
-- Name: shop_product_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.shop_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_product_id_seq OWNER TO admin;

--
-- Name: shop_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.shop_product_id_seq OWNED BY public.shop_product.id;


--
-- Name: shop_product_tag; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.shop_product_tag (
    product_id bigint NOT NULL,
    hashtag_id character varying(64) NOT NULL
);


ALTER TABLE public.shop_product_tag OWNER TO admin;

--
-- Name: shop_tag; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.shop_tag (
    hashtag character varying(64) NOT NULL
);


ALTER TABLE public.shop_tag OWNER TO admin;

--
-- Name: shop_ticket; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.shop_ticket (
    id bigint NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.shop_ticket OWNER TO admin;

--
-- Name: shop_ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.shop_ticket_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_ticket_id_seq OWNER TO admin;

--
-- Name: shop_ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.shop_ticket_id_seq OWNED BY public.shop_ticket.id;


--
-- Name: shop_ticket_response; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.shop_ticket_response (
    id bigint NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ticket_id bigint NOT NULL
);


ALTER TABLE public.shop_ticket_response OWNER TO admin;

--
-- Name: shop_ticket_response_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.shop_ticket_response_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_ticket_response_id_seq OWNER TO admin;

--
-- Name: shop_ticket_response_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.shop_ticket_response_id_seq OWNED BY public.shop_ticket_response.id;


--
-- Name: shop_transaction; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.shop_transaction (
    id bigint NOT NULL,
    status smallint NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    result json NOT NULL,
    total double precision NOT NULL,
    type smallint NOT NULL,
    courier_service character varying(64),
    shipment_number character(64),
    weight double precision,
    recipient character varying(256),
    address character varying(512),
    city character varying(128),
    province character varying(128),
    zip character varying(32),
    phone character varying(32),
    additional_info text,
    invoice character varying(64),
    order_id bigint NOT NULL
);


ALTER TABLE public.shop_transaction OWNER TO admin;

--
-- Name: shop_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.shop_transaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_transaction_id_seq OWNER TO admin;

--
-- Name: shop_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.shop_transaction_id_seq OWNED BY public.shop_transaction.id;


--
-- Name: shop_user; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.shop_user (
    id bigint NOT NULL,
    email character varying(128) NOT NULL,
    password character(128) NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    role smallint DEFAULT 0 NOT NULL,
    name character varying(64) NOT NULL,
    surname character varying(64) NOT NULL,
    gender smallint NOT NULL,
    phone character varying(16) NOT NULL,
    birth date NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.shop_user OWNER TO admin;

--
-- Name: shop_user_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.shop_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_user_id_seq OWNER TO admin;

--
-- Name: shop_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.shop_user_id_seq OWNED BY public.shop_user.id;


--
-- Name: shop_wish; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.shop_wish (
    product_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.shop_wish OWNER TO admin;

--
-- Name: shop_category id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_category ALTER COLUMN id SET DEFAULT nextval('public.shop_category_id_seq'::regclass);


--
-- Name: shop_feedback id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_feedback ALTER COLUMN id SET DEFAULT nextval('public.shop_feedback_id_seq'::regclass);


--
-- Name: shop_order id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_order ALTER COLUMN id SET DEFAULT nextval('public.order_id_seq'::regclass);


--
-- Name: shop_product id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_product ALTER COLUMN id SET DEFAULT nextval('public.shop_product_id_seq'::regclass);


--
-- Name: shop_ticket id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_ticket ALTER COLUMN id SET DEFAULT nextval('public.shop_ticket_id_seq'::regclass);


--
-- Name: shop_ticket_response id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_ticket_response ALTER COLUMN id SET DEFAULT nextval('public.shop_ticket_response_id_seq'::regclass);


--
-- Name: shop_transaction id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_transaction ALTER COLUMN id SET DEFAULT nextval('public.shop_transaction_id_seq'::regclass);


--
-- Name: shop_user id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_user ALTER COLUMN id SET DEFAULT nextval('public.shop_user_id_seq'::regclass);


--
-- Data for Name: shop_category; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.shop_category (id, parent_id, name) VALUES (1, NULL, 'Giardinaggio');
INSERT INTO public.shop_category (id, parent_id, name) VALUES (2, NULL, 'Elettronica');


--
-- Data for Name: shop_feedback; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: shop_order; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: shop_order_product; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: shop_product; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.shop_product (id, name, description, price, quantity, status, updated_at, created_at) VALUES (1, 'Solfato di ferro', 'Contiene solfato di ferro.', 30, 99, 0, '2020-12-11 23:35:31.995715', '2020-12-11 23:35:31.995715');
INSERT INTO public.shop_product (id, name, description, price, quantity, status, updated_at, created_at) VALUES (2, 'RoundUp', 'Erbicida/Diserbante', 7, 99, 0, '2020-12-11 23:36:16.836424', '2020-12-11 23:36:16.836424');


--
-- Data for Name: shop_product_category; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.shop_product_category (product_id, category_id) VALUES (1, 1);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (2, 1);


--
-- Data for Name: shop_product_tag; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: shop_tag; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: shop_ticket; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: shop_ticket_response; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: shop_transaction; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Data for Name: shop_user; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.shop_user (id, email, password, status, role, name, surname, gender, phone, birth, created_at, updated_at) VALUES (1, 'lollo@gmail.com', '324324                                                                                                                          ', 0, 0, 'Lollo', 'Guastalegname', 2, '3243432432', '1997-06-10', '2020-12-11 23:34:20.197463', '2020-12-11 23:34:20.197463');


--
-- Data for Name: shop_wish; Type: TABLE DATA; Schema: public; Owner: admin
--

INSERT INTO public.shop_wish (product_id, user_id) VALUES (1, 1);
INSERT INTO public.shop_wish (product_id, user_id) VALUES (2, 1);


--
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.order_id_seq', 1, false);


--
-- Name: shop_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.shop_category_id_seq', 1, false);


--
-- Name: shop_feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.shop_feedback_id_seq', 1, false);


--
-- Name: shop_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.shop_product_id_seq', 2, true);


--
-- Name: shop_ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.shop_ticket_id_seq', 1, false);


--
-- Name: shop_ticket_response_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.shop_ticket_response_id_seq', 1, false);


--
-- Name: shop_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.shop_transaction_id_seq', 1, false);


--
-- Name: shop_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.shop_user_id_seq', 1, true);


--
-- Name: shop_order order_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_order
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- Name: shop_category shop_category_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_category
    ADD CONSTRAINT shop_category_pkey PRIMARY KEY (id);


--
-- Name: shop_feedback shop_feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_feedback
    ADD CONSTRAINT shop_feedback_pkey PRIMARY KEY (id);


--
-- Name: shop_order_product shop_order_product_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_order_product
    ADD CONSTRAINT shop_order_product_pkey PRIMARY KEY (product_id, order_id);


--
-- Name: shop_product_category shop_product_category_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_product_category
    ADD CONSTRAINT shop_product_category_pkey PRIMARY KEY (product_id, category_id);


--
-- Name: shop_product shop_product_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_product
    ADD CONSTRAINT shop_product_pkey PRIMARY KEY (id);


--
-- Name: shop_product_tag shop_product_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_product_tag
    ADD CONSTRAINT shop_product_tag_pkey PRIMARY KEY (product_id, hashtag_id);


--
-- Name: shop_tag shop_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_tag
    ADD CONSTRAINT shop_tag_pkey PRIMARY KEY (hashtag);


--
-- Name: shop_ticket shop_ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_ticket
    ADD CONSTRAINT shop_ticket_pkey PRIMARY KEY (id);


--
-- Name: shop_ticket_response shop_ticket_response_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_ticket_response
    ADD CONSTRAINT shop_ticket_response_pkey PRIMARY KEY (id);


--
-- Name: shop_transaction shop_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_transaction
    ADD CONSTRAINT shop_transaction_pkey PRIMARY KEY (id);


--
-- Name: shop_user shop_user_email_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_user
    ADD CONSTRAINT shop_user_email_key UNIQUE (email);


--
-- Name: shop_user shop_user_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_user
    ADD CONSTRAINT shop_user_pkey PRIMARY KEY (id);


--
-- Name: shop_wish shop_wish_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_wish
    ADD CONSTRAINT shop_wish_pkey PRIMARY KEY (product_id, user_id);


--
-- Name: shop_category shop_category_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_category
    ADD CONSTRAINT shop_category_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.shop_category(id) NOT VALID;


--
-- Name: shop_feedback shop_feedback_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_feedback
    ADD CONSTRAINT shop_feedback_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.shop_product(id) ON DELETE CASCADE;


--
-- Name: shop_feedback shop_feedback_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_feedback
    ADD CONSTRAINT shop_feedback_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.shop_user(id) ON DELETE CASCADE;


--
-- Name: shop_order_product shop_order_product_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_order_product
    ADD CONSTRAINT shop_order_product_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.shop_order(id) ON DELETE CASCADE;


--
-- Name: shop_order_product shop_order_product_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_order_product
    ADD CONSTRAINT shop_order_product_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.shop_product(id) ON DELETE CASCADE;


--
-- Name: shop_product_category shop_product_category_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_product_category
    ADD CONSTRAINT shop_product_category_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.shop_category(id) ON DELETE CASCADE;


--
-- Name: shop_product_category shop_product_category_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_product_category
    ADD CONSTRAINT shop_product_category_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.shop_product(id) ON DELETE CASCADE;


--
-- Name: shop_product_tag shop_product_tag_hashtag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_product_tag
    ADD CONSTRAINT shop_product_tag_hashtag_id_fkey FOREIGN KEY (hashtag_id) REFERENCES public.shop_tag(hashtag) ON DELETE CASCADE;


--
-- Name: shop_product_tag shop_product_tag_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_product_tag
    ADD CONSTRAINT shop_product_tag_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.shop_product(id) ON DELETE CASCADE;


--
-- Name: shop_ticket_response shop_ticket_response_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_ticket_response
    ADD CONSTRAINT shop_ticket_response_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.shop_ticket(id) ON DELETE CASCADE;


--
-- Name: shop_ticket shop_ticket_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_ticket
    ADD CONSTRAINT shop_ticket_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.shop_user(id) ON DELETE CASCADE;


--
-- Name: shop_transaction shop_transaction_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_transaction
    ADD CONSTRAINT shop_transaction_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.shop_order(id) ON DELETE CASCADE NOT VALID;


--
-- Name: shop_wish shop_wish_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_wish
    ADD CONSTRAINT shop_wish_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.shop_product(id) ON DELETE CASCADE;


--
-- Name: shop_wish shop_wish_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_wish
    ADD CONSTRAINT shop_wish_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.shop_user(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

