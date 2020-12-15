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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: shop_category; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.shop_category (
    id bigint NOT NULL,
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
-- Name: shop_tag; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.shop_tag (
    id bigint NOT NULL,
    hashtag character varying(128) NOT NULL
);


ALTER TABLE public.shop_tag OWNER TO admin;

--
-- Name: shop_hashtag_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.shop_hashtag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_hashtag_id_seq OWNER TO admin;

--
-- Name: shop_hashtag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.shop_hashtag_id_seq OWNED BY public.shop_tag.id;


--
-- Name: shop_order; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.shop_order (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    status smallint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.shop_order OWNER TO admin;

--
-- Name: shop_order_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.shop_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_order_id_seq OWNER TO admin;

--
-- Name: shop_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.shop_order_id_seq OWNED BY public.shop_order.id;


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
    stock integer DEFAULT 0 NOT NULL,
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
    tag_id bigint NOT NULL
);


ALTER TABLE public.shop_product_tag OWNER TO admin;

--
-- Name: shop_product_tag_product_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.shop_product_tag_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_product_tag_product_id_seq OWNER TO admin;

--
-- Name: shop_product_tag_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.shop_product_tag_product_id_seq OWNED BY public.shop_product_tag.product_id;


--
-- Name: shop_product_tag_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.shop_product_tag_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_product_tag_tag_id_seq OWNER TO admin;

--
-- Name: shop_product_tag_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.shop_product_tag_tag_id_seq OWNED BY public.shop_product_tag.tag_id;


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
    response text NOT NULL,
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
    order_id bigint NOT NULL,
    transaction_code character varying(128)
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

ALTER TABLE ONLY public.shop_order ALTER COLUMN id SET DEFAULT nextval('public.shop_order_id_seq'::regclass);


--
-- Name: shop_product id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_product ALTER COLUMN id SET DEFAULT nextval('public.shop_product_id_seq'::regclass);


--
-- Name: shop_product_tag product_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_product_tag ALTER COLUMN product_id SET DEFAULT nextval('public.shop_product_tag_product_id_seq'::regclass);


--
-- Name: shop_product_tag tag_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_product_tag ALTER COLUMN tag_id SET DEFAULT nextval('public.shop_product_tag_tag_id_seq'::regclass);


--
-- Name: shop_tag id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_tag ALTER COLUMN id SET DEFAULT nextval('public.shop_hashtag_id_seq'::regclass);


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



--
-- Data for Name: shop_product_category; Type: TABLE DATA; Schema: public; Owner: admin
--



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

INSERT INTO public.shop_user (id, email, password, status, role, name, surname, gender, phone, birth, created_at, updated_at) VALUES (4, 'user@test.com', '123                                                                                                                             ', 0, 0, 'Utente', 'Prova', 3, '123456544', '1997-10-06', '2020-12-15 22:11:37.090536', '2020-12-15 22:11:37.090536');
INSERT INTO public.shop_user (id, email, password, status, role, name, surname, gender, phone, birth, created_at, updated_at) VALUES (5, 'admin@test.com', '123                                                                                                                             ', 0, 1, 'Admin', 'Prova', 3, '212312332', '1997-10-06', '2020-12-15 22:11:37.090536', '2020-12-15 22:11:37.090536');


--
-- Data for Name: shop_wish; Type: TABLE DATA; Schema: public; Owner: admin
--



--
-- Name: shop_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.shop_category_id_seq', 3, true);


--
-- Name: shop_feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.shop_feedback_id_seq', 1, true);


--
-- Name: shop_hashtag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.shop_hashtag_id_seq', 1, false);


--
-- Name: shop_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.shop_order_id_seq', 1, false);


--
-- Name: shop_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.shop_product_id_seq', 2, true);


--
-- Name: shop_product_tag_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.shop_product_tag_product_id_seq', 1, false);


--
-- Name: shop_product_tag_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.shop_product_tag_tag_id_seq', 1, false);


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

SELECT pg_catalog.setval('public.shop_transaction_id_seq', 1, true);


--
-- Name: shop_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.shop_user_id_seq', 5, true);


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
-- Name: shop_tag shop_hashtag_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_tag
    ADD CONSTRAINT shop_hashtag_pkey PRIMARY KEY (id);


--
-- Name: shop_order shop_order_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_order
    ADD CONSTRAINT shop_order_pkey PRIMARY KEY (id);


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
    ADD CONSTRAINT shop_product_tag_pkey PRIMARY KEY (product_id, tag_id);


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
    ADD CONSTRAINT shop_order_product_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.shop_order(id) ON DELETE CASCADE NOT VALID;


--
-- Name: shop_order_product shop_order_product_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_order_product
    ADD CONSTRAINT shop_order_product_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.shop_product(id) ON DELETE CASCADE;


--
-- Name: shop_order shop_order_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_order
    ADD CONSTRAINT shop_order_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.shop_user(id) ON DELETE CASCADE;


--
-- Name: shop_product_category shop_product_category_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_product_category
    ADD CONSTRAINT shop_product_category_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.shop_product(id) ON DELETE CASCADE;


--
-- Name: shop_product_category shop_product_category_shop_category_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_product_category
    ADD CONSTRAINT shop_product_category_shop_category_id_fk FOREIGN KEY (category_id) REFERENCES public.shop_category(id) ON DELETE CASCADE;


--
-- Name: shop_product_tag shop_product_tag_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_product_tag
    ADD CONSTRAINT shop_product_tag_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.shop_product(id) ON DELETE CASCADE;


--
-- Name: shop_product_tag shop_product_tag_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_product_tag
    ADD CONSTRAINT shop_product_tag_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.shop_tag(id) ON DELETE CASCADE;


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
-- Name: shop_transaction shop_transaction_shop_order_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.shop_transaction
    ADD CONSTRAINT shop_transaction_shop_order_id_fk FOREIGN KEY (order_id) REFERENCES public.shop_order(id) ON DELETE CASCADE;


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

