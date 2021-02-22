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
-- Name: shop_auth; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shop_auth (
    id character varying(32) NOT NULL,
    expire timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    param bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.shop_auth OWNER TO postgres;

--
-- Name: shop_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shop_category (
    id bigint NOT NULL,
    name character varying(128) NOT NULL
);


ALTER TABLE public.shop_category OWNER TO postgres;

--
-- Name: shop_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shop_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_category_id_seq OWNER TO postgres;

--
-- Name: shop_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shop_category_id_seq OWNED BY public.shop_category.id;


--
-- Name: shop_feedback; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shop_feedback (
    id bigint NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    vote real DEFAULT 0 NOT NULL,
    product_id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    user_id bigint NOT NULL,
    status smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.shop_feedback OWNER TO postgres;

--
-- Name: shop_feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shop_feedback_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_feedback_id_seq OWNER TO postgres;

--
-- Name: shop_feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shop_feedback_id_seq OWNED BY public.shop_feedback.id;


--
-- Name: shop_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shop_tag (
    id bigint NOT NULL,
    hashtag character varying(128) NOT NULL
);


ALTER TABLE public.shop_tag OWNER TO postgres;

--
-- Name: shop_hashtag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shop_hashtag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_hashtag_id_seq OWNER TO postgres;

--
-- Name: shop_hashtag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shop_hashtag_id_seq OWNED BY public.shop_tag.id;


--
-- Name: shop_order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shop_order (
    id bigint NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    result text DEFAULT '{}'::text NOT NULL,
    price real DEFAULT 0 NOT NULL,
    transaction_id character varying(32) DEFAULT ''::character varying NOT NULL,
    transaction_type smallint DEFAULT 0 NOT NULL,
    shipment_number character varying(64) DEFAULT ''::character varying NOT NULL,
    address text DEFAULT ''::text NOT NULL,
    city text DEFAULT ''::text NOT NULL,
    province text DEFAULT ''::text NOT NULL,
    zip text DEFAULT ''::text NOT NULL,
    additional_info text DEFAULT ''::text NOT NULL,
    invoice character varying(64) DEFAULT ''::character varying NOT NULL,
    user_id bigint,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.shop_order OWNER TO postgres;

--
-- Name: shop_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shop_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_order_id_seq OWNER TO postgres;

--
-- Name: shop_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shop_order_id_seq OWNED BY public.shop_order.id;


--
-- Name: shop_order_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shop_order_product (
    product_id bigint NOT NULL,
    order_id bigint NOT NULL,
    quantity integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.shop_order_product OWNER TO postgres;

--
-- Name: shop_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shop_product (
    id bigint NOT NULL,
    name character varying(256) NOT NULL,
    description text NOT NULL,
    price real DEFAULT 0 NOT NULL,
    stock integer DEFAULT 0 NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    info text,
    discount real DEFAULT 0 NOT NULL
);


ALTER TABLE public.shop_product OWNER TO postgres;

--
-- Name: shop_product_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shop_product_category (
    product_id bigint NOT NULL,
    category_id bigint NOT NULL
);


ALTER TABLE public.shop_product_category OWNER TO postgres;

--
-- Name: shop_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shop_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_product_id_seq OWNER TO postgres;

--
-- Name: shop_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shop_product_id_seq OWNED BY public.shop_product.id;


--
-- Name: shop_product_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shop_product_tag (
    product_id bigint NOT NULL,
    tag_id bigint NOT NULL
);


ALTER TABLE public.shop_product_tag OWNER TO postgres;

--
-- Name: shop_ticket; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.shop_ticket OWNER TO postgres;

--
-- Name: shop_ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shop_ticket_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_ticket_id_seq OWNER TO postgres;

--
-- Name: shop_ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shop_ticket_id_seq OWNED BY public.shop_ticket.id;


--
-- Name: shop_ticket_response; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shop_ticket_response (
    id bigint NOT NULL,
    response text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ticket_id bigint NOT NULL
);


ALTER TABLE public.shop_ticket_response OWNER TO postgres;

--
-- Name: shop_ticket_response_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shop_ticket_response_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_ticket_response_id_seq OWNER TO postgres;

--
-- Name: shop_ticket_response_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shop_ticket_response_id_seq OWNED BY public.shop_ticket_response.id;


--
-- Name: shop_user; Type: TABLE; Schema: public; Owner: postgres
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
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    auth smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.shop_user OWNER TO postgres;

--
-- Name: shop_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shop_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shop_user_id_seq OWNER TO postgres;

--
-- Name: shop_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shop_user_id_seq OWNED BY public.shop_user.id;


--
-- Name: shop_wish; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shop_wish (
    product_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.shop_wish OWNER TO postgres;

--
-- Name: shop_category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_category ALTER COLUMN id SET DEFAULT nextval('public.shop_category_id_seq'::regclass);


--
-- Name: shop_feedback id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_feedback ALTER COLUMN id SET DEFAULT nextval('public.shop_feedback_id_seq'::regclass);


--
-- Name: shop_order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_order ALTER COLUMN id SET DEFAULT nextval('public.shop_order_id_seq'::regclass);


--
-- Name: shop_product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_product ALTER COLUMN id SET DEFAULT nextval('public.shop_product_id_seq'::regclass);


--
-- Name: shop_tag id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_tag ALTER COLUMN id SET DEFAULT nextval('public.shop_hashtag_id_seq'::regclass);


--
-- Name: shop_ticket id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_ticket ALTER COLUMN id SET DEFAULT nextval('public.shop_ticket_id_seq'::regclass);


--
-- Name: shop_ticket_response id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_ticket_response ALTER COLUMN id SET DEFAULT nextval('public.shop_ticket_response_id_seq'::regclass);


--
-- Name: shop_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_user ALTER COLUMN id SET DEFAULT nextval('public.shop_user_id_seq'::regclass);


--
-- Data for Name: shop_auth; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: shop_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shop_category (id, name) VALUES (2, 'Pesticidi');
INSERT INTO public.shop_category (id, name) VALUES (1, 'Casalinghi');
INSERT INTO public.shop_category (id, name) VALUES (4, 'Funghicidi');
INSERT INTO public.shop_category (id, name) VALUES (5, 'Erbicidi');
INSERT INTO public.shop_category (id, name) VALUES (6, 'Alimentari');
INSERT INTO public.shop_category (id, name) VALUES (7, 'Giardinaggio');
INSERT INTO public.shop_category (id, name) VALUES (8, 'Infortunistica');
INSERT INTO public.shop_category (id, name) VALUES (9, 'Mangimi');
INSERT INTO public.shop_category (id, name) VALUES (10, 'Ferramenta');
INSERT INTO public.shop_category (id, name) VALUES (3, 'Insetticidi');


--
-- Data for Name: shop_feedback; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shop_feedback (id, title, description, vote, product_id, created_at, updated_at, user_id, status) VALUES (34, 'Fantastico!!', 'Sperando possa scaldare anche il cuore di Francesco!!', 4, 251, '2021-01-28 00:49:17.32', '2021-01-28 00:49:17.32', 23, 0);
INSERT INTO public.shop_feedback (id, title, description, vote, product_id, created_at, updated_at, user_id, status) VALUES (35, 'Woow!!', ':- pellet(X, Y), recensione(Y), Y != 5.', 5, 251, '2021-01-28 00:59:48.983', '2021-01-28 00:59:48.983', 25, 0);
INSERT INTO public.shop_feedback (id, title, description, vote, product_id, created_at, updated_at, user_id, status) VALUES (36, 'Sublime.', 'Tentar con le parole d’estinguer quella fiamma d’amore è tanto facile quanto attizzare il fuoco con la neve.', 2, 251, '2021-01-28 01:03:21.403', '2021-01-28 01:03:21.403', 26, 0);


--
-- Data for Name: shop_order; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: shop_order_product; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: shop_product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (254, 'Scarpe anti-infortunio', 'Sportivi e sicuri<br><br>

È raro trovare una combinazione così ben riuscita di abbigliamento sportivo e antinfortunistico, ma è esattamente questo che Black Hammer è riuscita a ottenere con il modello 9952. Dal loro aspetto esteriore, probabilmente non diresti mai che questa scarpe nascondono una grande robustezza sotto alla loro estetica delicata.
<br>
Naturalmente eleganti, queste scarpe con puntale in acciaio hanno la linea di una scarpa sportiva alla moda, con lati bassi e linguetta alta. La fodera traspirante, le suole antiscivolo e il bordo del tallone sagomato ti permette di svolgere tutte le attività che desideri indossando queste scarpe, godendo del massimo comfort di aderenza allo stesso tempo.
<br>
Nelle situazioni di lavoro e nelle attività all’aperto, puoi essere certo che la tua sicurezza sia perfettamente garantita perché queste scarpe sono conformi alle norme di sicurezza più rigorose. La loro classificazione S1P significa che sono in grado di sopportare urti fino a 200 joule e compressioni fino a 1,5 tonnellate: valori che in termini di sicurezza li pongono allo stesso livello di scarpe antinfortunistiche molto più ingombranti. La lamina antiforo nell’intersuola, inoltre, protegge dagli oggetti taglienti sul terreno.
<br><br>
Caratteristiche<br>
Robuste scarpe antinfortunistiche S1P<br>
Studiati per sopportare le condizioni più difficili<br>
Suole antiscivolo resistenti all’usura e all’olio<br>
Garanzia sulle suole di 6 mesi Black Hammer<br>
Solette a supporto anatomico e fodera traspirante<br>
Idonei per un’ampia gamma di utilizzi, quali lavoro, trekking<br>
Disponibili nelle taglie EU 41-45<br><br>

Se desideri un paio di scarpe da poter usare sia sul lavoro che nel tempo libero senza incidenti, hai trovato ciò che ti serve.<br>', 49.9, 999, 0, '2021-01-27 21:27:14.589418', '2021-01-27 21:27:14.589418', 'Scarpe antinfortunistiche con puntale in acciaio e plantare modello 9952', 25);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (251, 'Pellet', 'Pellet per stufe super Eco classe A1 kg. 15<br>
Prodotto costituito per il 100% da sola segatura e privo di qualsiasi colla o additivo, 
risulta essere utilizzato come combustibile per stufe, camini, caldaie, ecc...<br>
<br>
Il colore brunastro di tale prodotto è dovuto alla percentuale di legno di faggio che risulta ottimo in resa calorica.<br>
<br>
La pochissima percentuale di cenere prodotta può essere utilizzata come fertilizzante in grado di apportare elementi nutritivi al terreno.<br>', 5, 979, 0, '2021-02-05 13:55:43.242723', '2021-01-27 21:12:08.283606', 'Pellet per stufe super Eco classe A1 kg. 15<br>
Prodotto costituito per il 100% da sola segatura e privo di qualsiasi colla o additivo, risulta essere utilizzato come combustibile per stufe, camini, caldaie, ecc...<br>
', 10);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (258, 'Insetticida cc.', '<ul class="a-unordered-list a-vertical a-spacing-mini">


<li><span class="a-list-item">
Elevata persistenza d''azione, ideale per interni ed esterni


</span></li>


<li><span class="a-list-item">
Crea una barriera sul perimetro dell''area trattata


</span></li>


<li><span class="a-list-item">
Specifico per la disinfestazione domestica, di parchi ed aree verdi di ogni dimensione, ideale per le siepi di confine


</span></li>


<li><span class="a-list-item">
Super-concentrato diluibile 0,5-1%


</span></li>


<li><span class="a-list-item">
Made in Italy


</span></li>


</ul>', 39.9, 999, 0, '2021-01-27 21:40:06.975317', '2021-01-27 21:40:06.975317', 'Sandokan Insetticida Concentrato Abbattente Bio Revanol formula PLUS 10% 1L adatto contro zanzare e insetti volanti e striscianti Azione immediata per giardini prati e siepi', 25);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (256, 'Insetticida abbattente', '<ul class="a-unordered-list a-vertical a-spacing-mini">


<li><span class="a-list-item">
Elevata persistenza d''azione, ideale per interni ed esterni


</span></li>


<li><span class="a-list-item">
Crea una barriera sul perimetro dell''area trattata


</span></li>


<li><span class="a-list-item">
Specifico per la disinfestazione domestica, di parchi ed aree verdi di ogni dimensione, ideale per le siepi di confine


</span></li>


<li><span class="a-list-item">
Super-concentrato diluibile 0,5-1%


</span></li>


<li><span class="a-list-item">
Made in Italy


</span></li>


</ul>', 39.9, 999, 0, '2021-01-27 21:37:04.668946', '2021-01-27 21:37:04.668946', 'Sandokan Insetticida Concentrato Abbattente Bio Revanol formula PLUS 10% 1L adatto contro zanzare e insetti volanti e striscianti Azione immediata per giardini prati e siepi', 25);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (257, 'Spruzzino nebulizzante', '<ul class="a-unordered-list a-vertical a-spacing-mini">


<li><span class="a-list-item">
Spruzzatore a pressione da 5 litri con contenitore traslucido e indicatori di livello neri di facile lettura in litri e once per una miscelazione chimica accurata.


</span></li>


<li><span class="a-list-item">
Da utilizzare con acqua o altri prodotti a base d''acqua non viscosi inclusi pesticidi, erbicidi, insetticidi, fungicidi, fertilizzanti da utilizzare in giardino, prati ecc. Offre una facile distribuzione e spruzzatura.


</span></li>


<li><span class="a-list-item">
Diametro del foro superiore di circa 35 mm per facilitare il riempimento, la miscelazione e la pulizia. Meccanismo di attivazione bloccabile opzionale per una modalità di spruzzatura continua. Tracolla per facilità di trasporto. L''ugello a spruzzo angolato facilita l''irrorazione della parte inferiore delle foglie e di altre zone difficili da raggiungere.


</span></li>


<li><span class="a-list-item">
Impugnatura ergonomica D per facilitare il pompaggio e aumentare la pressione. Lo spruzzatore è progettato per mantenere una pressione massima di 3 bar, dopo di che la valvola di sicurezza della pressione integrata inizia a rilasciare automaticamente la pressione in eccesso per garantire una maggiore sicurezza.


</span></li>


</ul>', 59.9, 999, 0, '2021-01-27 21:38:16.39105', '2021-01-27 21:38:16.39105', 'Spruzzatore a Pressione 5 Litri, Pompa Irroratrice, Pompa Acqua Manuale, Ideale con Diserbante, Pesticidi, Erbicidi, Insetticidi, Fungicidi - Nebulizzatore Piante Vaporizzatore Piante', 10);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (261, 'Bruciatore diserbante', '<ul class="a-unordered-list a-vertical a-spacing-mini">


<li><span class="a-list-item">
Usando temperature elevate fino a 650 gradi per distruggere le radici delle erbacce in breve tempo, i risultati possono di solito essere visti dopo 4 giorni.


</span></li>


<li><span class="a-list-item">
Le nostre diserbatrici elettriche non hanno fiamme, gas o sostanze chimiche dannose.


</span></li>


<li><span class="a-list-item">
Funzionamento semplice con cavo da 5 me 2 ugelli (diserbo / barbecue)


</span></li>


<li><span class="a-list-item">
Il nostro bruciatore elettrico può essere utilizzato anche come luce di fuoco o barbecue. Non c''è bisogno di bombole di gas o fiammiferi.


</span></li>


<li><span class="a-list-item">
Può controllando efficacemente le erbacce tra pietre per lastricati, passi carrai o cordoli di pietra.


</span></li>


</ul>', 99, 999, 0, '2021-01-27 21:47:50.936852', '2021-01-27 21:47:50.936852', 'VOUNOT Bruciatore Diserbante 2000W, Diserbante Termico Elettrico, Strumento Sarchiatura Elettrico Fino a 650 Gradi per Giardino, Patio, Vialetto', 30);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (260, 'Diserbante', 'GLIPHOGAN TOP CL è un erbicida da impiegarsi in post emergenza delle erbe infestanti nel controllo di specie mono e dicotiledoni', 10, 999, 0, '2021-01-27 21:46:14.755067', '2021-01-27 21:46:14.755067', 'adama DISERBANTE Totale ERBICIDA GLIFOSATE SISTEMICO 500 ML', 30);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (253, 'Maschera Antigas', 'CARATTERISTICHE TECNICHE
<br><br>
<ul><li>GUARNIZIONE FACCIALE In silicone con certificazione FDA (BLS 5700) per un miglior comfort.
</li>
<li>CONNESSIONE DEI FILTRI Il sistema a baionetta (tecnologia BLS b-lock) offre un sicuro e rapido attacco dei filtri.
</li><li>BARDATURA Fissata al corpo rigido su 6 punti di attacco, non lascia segni sul viso dell’utente. 
</li><li>VISORE in policarbonato testato in Classe ottica 1 (EN 166). Trattamento antigraffio. 
</li><li>VALVOLA DI ESPIRAZIONE Con copertura anti-schizzo.
</li></ul><br><br>Progettata per evitare l’appannamento della maschera.<br>
<small>Filtri della maschera a parte, si prega di scegliere quello ideale per le proprie esigenza.
Compreso di cappuccio resistente su tutti gli agenti chimici.</small><br>', 199.9, 995, 0, '2021-02-05 13:55:43.250245', '2021-01-27 21:22:12.493269', 'MASCHERA ANTIGAS FACCIALE CON PROTEZIONE OCCHI E CAPPUCCIO BLS 5700/C', 20);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (264, 'Nutella B-Ready', '<ul class="a-unordered-list a-vertical a-spacing-mini">


<li><span class="a-list-item">
NUTELLA B-READY E’ una cialda di pane di tipo «00» a forma di baguette, con farcitura di crema alle nocciole e al cacao Nutella e chicchi (2%) di cialda di pane


</span></li>


<li><span class="a-list-item">
NUTELLA B-READY Ovunque tu sia uno stacco gustoso per continuare con piacere le tue attività


</span></li>


<li><span class="a-list-item">
FORMATO Pratica confezione da 10 pezzi confezionati singolarmente


</span></li>


<li><span class="a-list-item">
LO SAPEVI CHE Nutella Bready è una cialda croccante di pane, il partner perfetto perfetto per la consistenza cremosa di Nutella


</span></li>


</ul>

', 5, 999, 0, '2021-01-27 21:53:44.254724', '2021-01-27 21:53:44.254724', 'Nutella B - Ready, Confezione da 10 Pezzi', 30);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (263, 'Tonno Riomare 7x80g', '<ul class="a-unordered-list a-vertical a-spacing-mini">


<li><span class="a-list-item">
Tonno all''olio di oliva con un pizzico di sale marino dal gusto inconfondibile e dal caratteristico colore rosa


</span></li>


<li><span class="a-list-item">
Formato: confezione da 7 lattine da 80 g ciascuna


</span></li>


<li><span class="a-list-item">
Ingredienti: tonno*, olio di oliva, sale. *Thunnus (neothunnus) albacares


</span></li>


<li><span class="a-list-item">
Consigli uso: ottimale per tutte le ricette, dai primi piatti alle insalatone fresche e golose


</span></li>


<li><span class="a-list-item">
Rio Mare. Qualità Responsabile dal mare alla tua tavola


</span></li>


</ul>', 10, 999, 0, '2021-01-27 21:52:22.572093', '2021-01-27 21:52:22.572093', 'Rio Mare, Tonno all''Olio di Oliva, Qualità Pinne Gialle, 7 Lattine da 80 g', 30);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (265, 'Ragù alla Bolognese', '<ul class="a-unordered-list a-vertical a-spacing-mini">


<li><span class="a-list-item">
IDEALE CON - Le Tagliatelle all''uovo Emiliane. Per esaltare profumo e sapore degli ingredienti si consiglia di scaldarlo a fuoco lento o nel microonde, dopo aver aperto il vasetto


</span></li>


<li><span class="a-list-item">
CARATTERISTICHE - La nostra Bolognese si prepara così: con pazienza, sapienza e niente conservanti aggiunti


</span></li>


<li><span class="a-list-item">
INGREDIENTI - Carne selezionata da filiera controllata, Pomodoro 100% italiano. Pronto per regalare alla tua pasta il sapore della buona cucina italiana


</span></li>


<li><span class="a-list-item">
SUGHI BARILLA - Tutti i sughi Barilla sono senza glutine e preparati senza aggiungere conservanti. Porta in tavola qualità e gusto con ingredienti semplici per deliziose ricette


</span></li>


<li><span class="a-list-item">
BARILLA - Un''azienda italiana di famiglia che coltiva la passione per la pasta dal 1877. I nostri sughi, pasta e cereali sono gustosi, sicuri e contribuiscono a una dieta equilibrata sulla tua tavola


</span></li>


</ul>', 2, 999, 0, '2021-01-27 21:54:29.257728', '2021-01-27 21:54:29.257728', 'Barilla Sugo Ragù alla Bolognese, Salsa Pronta al Pomodoro Italiano e Carne Selezionata senza Glutine, 400g', 30);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (262, 'Erbicida termico a gas', '<div id="feature-bullets" class="a-section a-spacing-medium a-spacing-top-small">




<ul class="a-unordered-list a-vertical a-spacing-mini">



<li><span class="a-list-item">
Diserbo naturale con temperatura fino a circa 1200° C


</span></li>


<li><span class="a-list-item">
Basso consumo di gas: 130 g / h


</span></li>


<li><span class="a-list-item">
Impugnatura ergonomica


</span></li>


<li><span class="a-list-item">
Prodotto polivalente e multiuso


</span></li>


<li><span class="a-list-item">
Erbicida termico ecologico, pirodiserbo della gamma Professional KZ GardenLancia con lunghezza di 80 cmFornito con 8 ricariche di gas UN 2037 standard da 400 mlErbicida polivalente con accensione piezoFiamma regolabile e impugnatura ergonomica per un facile utilizzoPeso della lancia : 0,5 KgPeso di una bombola : 0,33 Kg


</span></li>


</ul>', 40, 999, 0, '2021-01-27 21:48:46.092324', '2021-01-27 21:48:46.092324', 'Erbicida termico a gas + 8 ricariche - Ecologico per bruciare le erbe infestanti', 30);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (269, 'Supporto TV universale', '<ul class="a-unordered-list a-vertical a-spacing-mini">


<li><span class="a-list-item">
【Universale VESA】la nostra staffa per monitor è compatibile con monitor e TV da 10-26'''' con attacco VESA da 50 x 50 mm a 100 x 100 mm. Peso massimo: fino a 15 kg. NON usare su cartongesso.


</span></li>


<li><span class="a-list-item">
【Regolabile】permette di inclinare la TV o il monitor di 15° verso l''alto e 15° verso il basso per ridurre i riflessi e può essere spostato a destra e sinistra a piacimento. Si estende dalla parete fino a un massimo di 350 mm e si ritrae fino a 60 mm. Il sistema rotabile a 360° ne permette la completa personalizzazione.


</span></li>


<li><span class="a-list-item">
【Installazione Facile e Veloce】include tutti gli accessori di montaggio necessari, si installa in pochi semplici passaggi e include un manuale di istruzioni fai da te.


</span></li>


<li><span class="a-list-item">
【Una scelta sicura】design brevettato e certificato CE e RoHS, con 10 anni di garanzia; un prodotto che non ti delude, frutto di 25 anni di esperienza nel settore.


</span></li>


<li><span class="a-list-item">
【Servizio clienti eccezionale】preoccupato riguardo ingressi inaccessibili? Compatibilità VESA? Non sei sicuro se il tuo prodotto è compatibile? Contattaci ora e trova il supporto perfetto per la tua TV.


</span></li>


</ul>', 30.9, 999, 0, '2021-01-27 22:03:01.871983', '2021-01-27 22:03:01.871983', 'Supporto TV universale, Orientare, Inclinare, Ruotare – Adatto per TV LCD/LED a Schermo Piatto tra 13 e 42 pollici – Estendibile di 38.5cm – Sostiene fino a 20kg – Foratura VESA Massima 200X200mm', 20);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (270, 'Chiave universale regolabile', '<ul class="a-unordered-list a-vertical a-spacing-mini">


<li><span class="a-list-item">
【Ampia gamma di applicazioni】Questo kit è molto adatto per la riparazione o la sostituzione di accessori, valvole, tubi e tubature dell''acqua, radiatori di caldaie, ruote di automobili, sistemi di condizionamento dell''aria, ecc. In casa o in cucina o in bagno.


</span></li>


<li><span class="a-list-item">
【Dimensioni del prodotto】Chiave universale regolabile multifunzione con 3 dispositivi diversi. Chiave grande: intervallo 23-32 mm, lunghezza totale 28 cm; chiave piccola: campo applicabile 9-22 mm / 6-15 mm, lunghezza totale 21 cm.


</span></li>


<li><span class="a-list-item">
【Design pratico】Chiave Regolabile a Rullino per una varietà di dadi e bulloni e i denti sottili possono fissare saldamente tubi o viti rotondi, quadrati, a forma di diamante da 6-32 mm.


</span></li>


<li><span class="a-list-item">
【Alta qualità】Chiave Regolabile a Rullino realizzata in acciaio di alta qualità, tempra ad alta frequenza, superficie cromata, elevata durezza, buona tenacità, coppia elevata, punta meccanica del dente, forte forza di presa, durevole


</span></li>


<li><span class="a-list-item">
【Risparmio di tempo e fatica】 Set di chiavi regolabili , adatte a tutti i tipi di viti e dadi. Niente più ricerche fastidiose! Basta usare una chiave inglese e il resto può essere regolato da solo.


</span></li>


</ul>', 15.9, 999, 0, '2021-01-27 22:04:35.247079', '2021-01-27 22:04:35.247079', 'Nifogo Chiave universale regolabile multifunzione Universali Chiavi a Rullino Chiave Regolabile a Rullino con Apertura 9-32mm ', 10);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (271, 'Crocchette Cane Adulto', '<ul class="a-unordered-list a-vertical a-spacing-mini">


<li><span class="a-list-item">
Alimento completo e bilanciato per cani adulti


</span></li>


<li><span class="a-list-item">
Con manzo, cereali e verdure


</span></li>


<li><span class="a-list-item">
Aiuta a supportare le difese naturali del cane


</span></li>


<li><span class="a-list-item">
Con ingredienti accuratamente selezionati


</span></li>


<li><span class="a-list-item">
Senza coloranti, conservanti e aromi artificiali aggiunti


</span></li>


</ul>', 30.9, 999, 0, '2021-01-27 22:06:25.390378', '2021-01-27 22:06:25.390378', 'PURINA FRISKIES Crocchette Cane Adulto con Manzo, Cereali e Verdure Aggiunte, 15 kg', 20);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (280, 'Cuociriso e Vaporiera', '<ul class="a-unordered-list a-vertical a-spacing-mini">


<li><span class="a-list-item">
Funziona sia come Cuociriso che come Vaporiera, 2 prodotti in 1


</span></li>


<li><span class="a-list-item">
Include un cestello per cuocere verdure carne e pesce a vapore


</span></li>


<li><span class="a-list-item">
Funzione di mantenimento in caldo automatica


</span></li>


<li><span class="a-list-item">
Pentola interna antiaderenete e Coperchio sono rimovibilei e lavabili in lavastoviglie


</span></li>


<li><span class="a-list-item">
Include misurino e mestolo


</span></li>


</ul>', 69, 999, 0, '2021-01-27 22:19:13.38721', '2021-01-27 22:19:13.38721', 'Russell Hobbs Cuociriso e Vaporiera 27080-56, 14 Porzioni, Include cesta per cuocere a vapore Carne e Verdure, Pentola e Coperchio lavabili in Lavastoviglie, 500W', 20);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (276, 'Albero di Natale', '<ul class="a-unordered-list a-vertical a-spacing-mini">


<li><span class="a-list-item">
★ Dimensioni:★- Altezza 2,1m con 1200 punte, larghezza inferiore 104cm, peso del pacchetto 5kg.


</span></li>


<li><span class="a-list-item">
★Aghi in PVC Ignifugodi Buona Qualità★- Lo spessore degli aghi è di 0,07 cm, la larghezza dei rami è di 6 cm.


</span></li>


<li><span class="a-list-item">
★Base di Metallo Robusto★- Il nostro albero di natale ha una base in ferro da quattro piedi con una superficie finita, quindi anche all''aperto Non arrugginirà.


</span></li>


<li><span class="a-list-item">
★Facile da Montare★- Ci sono 3 parti nel pacchetto: ramo superiore, ramo inferiore e supporto. Per assemblarlo, bastano 4 passaggi: aprire il supporto; inserire il ramo inferiore, girare attorno alla vite e quindi inserire il ramo superiore. E’ possibile perdere pochi aghi nel montaggio.


</span></li>


<li><span class="a-list-item">
★Ti Dà Un Tocco di Atmosfera Natalizia alla Casa★ Questo albero di natale è realistico, folto, molto robusto e con ottimi materiali, se stai cercando un albero folto e realisto ad un prezzo accessibile ed economico,questa è la tua scelta migliore.


</span></li>


</ul>

', 50.9, 999, 0, '2021-01-27 22:13:27.837386', '2021-01-27 22:13:27.837386', 'TopVita Albero di Natale Bianco Verde, Albero di Natale Artificiale in PVC Ignifugodi in Diverse Misure (Verde, 2,1 Metri)', 20);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (275, 'Solfato di ferro', '<ul class="a-unordered-list a-vertical a-spacing-mini">


<li><span class="a-list-item">
Concime in polvere a base di ferro per tutte le colture con effetto prolungato


</span></li>


<li><span class="a-list-item">
Contiene ferro e zolfo


</span></li>


<li><span class="a-list-item">
Per prevenire gli ingiallimenti da clorosi ferrica


</span></li>


<li><span class="a-list-item">
Effetto antimuschio sui prati ornamentali. Non distribuire in presenza di marmi, piastrelle ed altro tipo di pavimentazione in quanto può macchiare. Se ne sconsiglia l’uso in vaso.


</span></li>


<li><span class="a-list-item">
ESSENDO UN SALE DI GRANULOMETRIA FINE, PER FACILITARE LA DISTRIBUZIONE, CONSIGLIAMO DI DILUIRLO IN ACQUA ALLA DOSE DI 200 gr OGNI 10 lt E DI BAGNARE IL PRATO DA TRATTARE IN MODO UNIFORME. In alternativa, consigliamo il prodotto corrispondente granulare Ferrogran e di attenersi alla dose minima.


</span></li>


<li><span class="a-list-item">
ESSENDO UN SALE DI GRANULOMETRIA FINE, PER FACILITARE LA DISTRIBUZIONE, CONSIGLIAMO DI DILUIRLO IN ACQUA ALLA DOSE DI 200 gr OGNI 10 lt E DI BAGNARE IL PRATO DA TRATTARE IN MODO UNIFORME. In alternativa, consigliamo il prodotto corrispondente granulare Ferrogran e di attenersi alla dose minima.


</span></li>


</ul>', 9.8, 999, 0, '2021-01-27 22:11:31.184166', '2021-01-27 22:11:31.184166', 'SOLFERRO, solfato di ferro in polvere, kg 5', 20);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (268, 'Cassetta attrezzi 56pz', '<ul class="a-unordered-list a-vertical a-spacing-mini">


<li><span class="a-list-item">
▲ TACKLIFE home tool kit materiale CR-V: fornisce una maggiore tenacità e durezza; superficie di placcatura: aumenta l capacità anticorrosiva valigetta portautensili portatile: mantieni tutti gli strumenti in uno stato ordinato, stabile e sicuro.Grande durata: dopo 500 volte di test di apertura e chiusura, i fermi funzionano ancora bene


</span></li>


<li><span class="a-list-item">
▲ strumenti generali oltre alla configurazione di base - martello, pinze, forbici, metro a nastro, cacciavite di precisione, ecc., il set di strumenti include anche una chiave esagonale metrica extra 7pcs e punte 30pcs spesso utilizzate


</span></li>


<li><span class="a-list-item">
▲ ampia applicazione il set di strumenti può essere utilizzato in ambienti domestici e all''aperto, l''installazione e l manutenzione di automobili, lavelli da cucina, biciclette, magazzini, tubature dell''acqua, ecc


</span></li>


<li><span class="a-list-item">
▲ confortevole design delle impugnature handles le impugnature ergonomiche offrono una presa e una maneggevolezza ottimali


</span></li>


<li><span class="a-list-item">
▲ conveniente con un prezzo ragionevole, alta qualità e portabilità, è l scelta ideale per uso domestico o regalo per i tuoi amici e familiari


</span></li>


</ul>

', 49.9, 999, 0, '2021-01-27 22:01:13.936745', '2021-01-27 22:01:13.936745', 'TACKLIFE,Set di Attrezzi,56 Pezzi,Cassetta Attrezzi,SET ATTREZZI,Set Porta Attrezzi Uso Domestico Riparazione,Perfetto Per tutti i lavori di Fai-da-te a Casa,Martello,Coltello,Cacciavite-HHK3B', 30);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (255, 'Gilet riflettente', '<ul class="a-unordered-list a-vertical a-spacing-mini">


<li><span class="a-list-item">
✔ 【IVA】 Siamo in grado di emettere fatture IVA. Se è necessario personalizzare il LOGO o avere altri requisiti sul prodotto, contattare l''assistenza clienti prima di effettuare l''acquisto.


</span></li>


<li><span class="a-list-item">
✔ 【Alta visibilità】RIFLETTIVITÀ 360 °:giubbotto gilet da lavoro alta visibilita giallo fluo blu scuro arancione blu pinke rosso viola è ad alta visibilità con strisce riflettenti larghe due pollici lungo la vita, il torace, le spalle e la schiena che offrono una protezione a 360 ° per farti stare in piedi fuori dal buio e facilmente rilevabile dai fari di un''auto sia che corri o lavoro in condizioni di scarsa illuminazione, sia facile da trovare e prendere misure in anticipo.


</span></li>


<li><span class="a-list-item">
Poliestere


</span></li>


<li><span class="a-list-item">
✔ 【Tasche multifunzione】 Gilet di sicurezza ad alta visibilità progettati con 7 tasche frontali con chiusura a conchiglia con bottone in nylon con cerniera, 2 grandi tasche, 1 porta badge ID in PVC trasparente, 1 tasca con patta e 1 custodia per torcia, puntatore laser. Le 2 tasche inclinate sono più adatti per la progettazione del corpo umano e più facili da posizionare ed estrarre. Trattamento rinforzante della cerniera.


</span></li>


<li><span class="a-list-item">
✔ 【MATERIALI】 MATERIALI: materiale riflettenti 100% poliestere ad alta visibilità, leggero e traspirante, lavabile e resistente. I bordi neri non sono facili da sporcare e più facili da abbinare. CERTIFICAZIONI: materiale riflettente di alta qualità nel pieno rispetto delle norme EN20471 Classe 2.


</span></li>


<li><span class="a-list-item">
✔ 【APPLICAZIONI INDUSTRIALI】 APPLICAZIONI INDUSTRIALI: Aeroporto, movimentazione bagagli, costruzione, demolizione, emergenza, primo soccorritore,lavoro, paesaggistica, pavimentazione, polizia, ferrovia, servizi igienico-sanitari, sicurezza, geometra e TSA


</span></li>


</ul>

', 19.9, 999, 0, '2021-01-27 21:30:18.099154', '2021-01-27 21:30:18.099154', 'AYKRM Gilet Tecnica da Lavoro Antinfortunistici Alta visibilità', 30);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (273, 'Purina Felix', '<ul class="a-unordered-list a-vertical a-spacing-mini">


<li><span class="a-list-item">
Alimento completo, ottimo per l''alimentazione quotidiana del tuo gatto


</span></li>


<li><span class="a-list-item">
Arricchito di una deliziosa gelatina che rende l''alimento gustoso ed appetibile


</span></li>


<li><span class="a-list-item">
Ricco di Vitamina E e D, Omega 6 e Minerali


</span></li>


<li><span class="a-list-item">
Creato con carni di qualità


</span></li>


</ul>', 35.9, 999, 0, '2021-01-27 22:07:51.321847', '2021-01-27 22:07:51.321847', 'Purina Felix Le Ghiottonerie Umido Gatto con Manzo, Pollo, Merluzzo e Tonno, 80 Buste da 100 g Ciascuna', 20);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (278, 'Spirilizzatore', '<ul class="a-unordered-list a-vertical a-spacing-mini">


<li><span class="a-list-item">
【Versione aggiornata】Lo spiralizzatore di verdure dispone di una ventosa collocata sul fondo per fissarlo meglio e renderne più comodo e facile l’uso. Dotato di 5 lame di diverse dimensioni da scegliere per ogni occasione, è più flessibile e conveniente. Lo spiralizzatore di nuovo modello ha un contenitore di collezione apposito sotto, non bisogna piu’mettere un contenitore al fianco da conservare il cibo.


</span></li>


<li><span class="a-list-item">
【Alta efficienza】Basta usare una mano sullla manovella e leggermente spingere l''Affettatrice di verdure in avanti per affetta zucchine spaghetti, risparmia meglio la forza.


</span></li>


<li><span class="a-list-item">
【Conveniente da lavare】La pulizia è semplice perché l''affettaverdure è staccabile e le parti smontate si possono tutti lavare in lavastoviglie. Si prega di fare attenzione alle lame poiché sono abbastanza affilate.


</span></li>


<li><span class="a-list-item">
【Ottima qualità】L''affettaverdure fatto di materiali resistenti e compatti alimentari, nel frattempo adatta a lavorare gli alimenti, non nuociono alla salute, alta qualità ad un prezzo competitivo.


</span></li>


<li><span class="a-list-item">
【CONSULTAZONE】Il venditore fornisce consultazione di 24 mesi, di 30 giorni soddisfatti o rimborsati per permettere di verificare l’idoneita’ dell''affettaverdure. Si prega di consultare il manuale dell''utente prima dell ''uso.


</span></li>


</ul>

23:17
Cuociriso e Vaporiera
', 35.9, 999, 0, '2021-01-27 22:18:01.052103', '2021-01-27 22:18:01.052103', 'Sedhoom spiralizzatore/Affettatrice di verdure verticale con 4 lame per tagliare/affettare frutta e verdure a julienne, migliore Tagliaverdure/Affettaverdure a spirale affetta zucchine spaghetti
', 30);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (274, 'Goldfish Flakes', '<ul class="a-unordered-list a-vertical a-spacing-mini">


<li><span class="a-list-item">
Miscela di fiocchi ottimamente bilanciata per una dieta varia


</span></li>


<li><span class="a-list-item">
Contiene tutte le sostanze nutrienti essenziali e gli oligoelementi


</span></li>


<li><span class="a-list-item">
Stimola il benessere e la vitalità, ravviva i colori


</span></li>


<li><span class="a-list-item">
Con la formula BioActive per una vita del pesce lunga e sana


</span></li>


<li><span class="a-list-item">
Tappo dosatore per un dosaggio più accurato e semplice


</span></li>


</ul>', 15.9, 999, 0, '2021-01-27 22:11:31.184166', '2021-01-27 22:11:31.184166', 'Tetra Goldfish Flakes Mangime in Fiocchi, Mangime per Pesci per Tutti i Pesci Rossi e Altri Pesci d''Acqua Fredda - 250 ml', 25);
INSERT INTO public.shop_product (id, name, description, price, stock, status, updated_at, created_at, info, discount) VALUES (252, 'Rete per olive', 'RETE A TELO PER RACCOLTA OLIVE ANTISPINA TIPO BARESE CON SPACCO MT. 6 X 6 CON OCCHIELLI
<br><br>
Lo spacco è a metà del telo
<br><br>
Realizzata in polietilene stabilizzato contro i raggi ultravioletti, di colore verde, è impiegata per la raccolta delle olive, noci, mandorle, castagne e frutta caduta.
<br><br>
PESO MQ. 100 GR.<br>', 29.9, 991, 0, '2021-02-05 13:55:43.24761', '2021-01-27 21:15:33.085907', 'RETE A TELO PER RACCOLTA OLIVE ANTISPINA TIPO BARESE CON SPACCO MT. 6 X 6 CON OCCHIELLI', 25);


--
-- Data for Name: shop_product_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shop_product_category (product_id, category_id) VALUES (251, 7);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (252, 7);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (253, 8);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (254, 8);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (255, 8);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (256, 3);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (257, 7);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (258, 3);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (260, 5);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (261, 5);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (262, 5);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (263, 6);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (264, 6);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (265, 6);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (268, 10);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (269, 10);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (270, 10);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (271, 9);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (273, 9);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (274, 9);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (275, 3);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (276, 1);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (278, 1);
INSERT INTO public.shop_product_category (product_id, category_id) VALUES (280, 1);


--
-- Data for Name: shop_product_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (251, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (252, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (253, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (254, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (255, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (256, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (257, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (258, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (260, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (261, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (262, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (263, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (264, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (265, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (268, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (269, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (270, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (271, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (273, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (274, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (275, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (276, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (278, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (280, 2);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (251, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (252, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (253, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (254, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (255, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (256, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (257, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (258, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (260, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (261, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (262, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (263, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (264, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (265, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (268, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (269, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (270, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (271, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (273, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (274, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (275, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (276, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (278, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (280, 6);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (257, 1);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (258, 1);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (260, 1);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (261, 1);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (262, 1);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (263, 1);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (276, 4);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (278, 4);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (280, 4);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (263, 3);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (264, 3);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (265, 3);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (268, 3);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (269, 3);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (270, 3);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (251, 1);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (252, 1);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (253, 1);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (254, 1);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (255, 1);
INSERT INTO public.shop_product_tag (product_id, tag_id) VALUES (256, 1);


--
-- Data for Name: shop_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shop_tag (id, hashtag) VALUES (2, '#sale');
INSERT INTO public.shop_tag (id, hashtag) VALUES (4, '#winter');
INSERT INTO public.shop_tag (id, hashtag) VALUES (3, '#blackfriday');
INSERT INTO public.shop_tag (id, hashtag) VALUES (1, '#hot');
INSERT INTO public.shop_tag (id, hashtag) VALUES (5, '#cheap');
INSERT INTO public.shop_tag (id, hashtag) VALUES (6, '#top');


--
-- Data for Name: shop_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: shop_ticket_response; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: shop_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shop_user (id, email, password, status, role, name, surname, gender, phone, birth, created_at, updated_at, auth) VALUES (34, 'inferdevil97@gmail.com', '<<AUTH_TYPE_GOOGLE>>                                                                                                            ', 1, 0, 'Antonio', 'Natale', 1, '', '1997-10-06', '2021-01-28 18:28:40.09', '2021-01-28 18:28:51.343346', 1);
INSERT INTO public.shop_user (id, email, password, status, role, name, surname, gender, phone, birth, created_at, updated_at, auth) VALUES (1, 'postgres@test.com', '804f50ddbaab7f28c933a95c162d019acbf96afde56dba10e4c7dfcfe453dec4bacf5e78b1ddbdc1695a793bcb5d7d409425db4cc3370e71c4965e4ef992e8c4', 1, 1, 'postgres', 'Prova', 1, '12345678', '2020-12-15', '2020-12-15 23:06:01.268677', '2020-12-15 23:06:01.268677', 0);
INSERT INTO public.shop_user (id, email, password, status, role, name, surname, gender, phone, birth, created_at, updated_at, auth) VALUES (2, 'user@test.com', '804f50ddbaab7f28c933a95c162d019acbf96afde56dba10e4c7dfcfe453dec4bacf5e78b1ddbdc1695a793bcb5d7d409425db4cc3370e71c4965e4ef992e8c4', 1, 0, 'Utente', 'Prova', 2, '12345678', '2020-12-15', '2020-12-15 23:06:01.268', '2020-12-15 23:06:01.268', 0);
INSERT INTO public.shop_user (id, email, password, status, role, name, surname, gender, phone, birth, created_at, updated_at, auth) VALUES (23, 'carmine@dodaro.it', '804f50ddbaab7f28c933a95c162d019acbf96afde56dba10e4c7dfcfe453dec4bacf5e78b1ddbdc1695a793bcb5d7d409425db4cc3370e71c4965e4ef992e8c4', 1, 0, 'Carmine', 'Dodaro', 1, '3334445566', '1990-01-05', '2021-01-28 00:45:17.475', '2021-01-28 00:45:17.475', 0);
INSERT INTO public.shop_user (id, email, password, status, role, name, surname, gender, phone, birth, created_at, updated_at, auth) VALUES (24, 'giovan@ianni.it', '804f50ddbaab7f28c933a95c162d019acbf96afde56dba10e4c7dfcfe453dec4bacf5e78b1ddbdc1695a793bcb5d7d409425db4cc3370e71c4965e4ef992e8c4', 1, 0, 'Giovanbattista', 'Ianni', 1, '3334445566', '1990-01-05', '2021-01-27 23:51:32.78425', '2021-01-27 23:51:32.78425', 0);
INSERT INTO public.shop_user (id, email, password, status, role, name, surname, gender, phone, birth, created_at, updated_at, auth) VALUES (25, 'simona@perri.it', '804f50ddbaab7f28c933a95c162d019acbf96afde56dba10e4c7dfcfe453dec4bacf5e78b1ddbdc1695a793bcb5d7d409425db4cc3370e71c4965e4ef992e8c4', 1, 0, 'Simona', 'Perri', 2, '3334445566', '1990-01-05', '2021-01-27 23:52:39.053608', '2021-01-27 23:52:39.053608', 0);
INSERT INTO public.shop_user (id, email, password, status, role, name, surname, gender, phone, birth, created_at, updated_at, auth) VALUES (26, 'pasquale@rullo.it', '804f50ddbaab7f28c933a95c162d019acbf96afde56dba10e4c7dfcfe453dec4bacf5e78b1ddbdc1695a793bcb5d7d409425db4cc3370e71c4965e4ef992e8c4', 1, 0, 'Pasquale', 'Rullo', 1, '3334445566', '1990-01-05', '2021-01-27 23:55:04.005888', '2021-01-27 23:55:04.005888', 0);
INSERT INTO public.shop_user (id, email, password, status, role, name, surname, gender, phone, birth, created_at, updated_at, auth) VALUES (27, 'gianluigi@greco.it', '804f50ddbaab7f28c933a95c162d019acbf96afde56dba10e4c7dfcfe453dec4bacf5e78b1ddbdc1695a793bcb5d7d409425db4cc3370e71c4965e4ef992e8c4', 1, 0, 'Gianluigi', 'Greco', 1, '3334445566', '1990-01-05', '2021-01-27 23:55:04.005888', '2021-01-27 23:55:04.005888', 0);
INSERT INTO public.shop_user (id, email, password, status, role, name, surname, gender, phone, birth, created_at, updated_at, auth) VALUES (28, 'giovanni@grasso.it', '804f50ddbaab7f28c933a95c162d019acbf96afde56dba10e4c7dfcfe453dec4bacf5e78b1ddbdc1695a793bcb5d7d409425db4cc3370e71c4965e4ef992e8c4', 1, 0, 'Giovanni', 'Grasso', 1, '3334445566', '1990-01-05', '2021-01-27 23:55:04.005888', '2021-01-27 23:55:04.005888', 0);


--
-- Data for Name: shop_wish; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shop_wish (product_id, user_id) VALUES (253, 2);
INSERT INTO public.shop_wish (product_id, user_id) VALUES (261, 2);


--
-- Name: shop_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_category_id_seq', 10, true);


--
-- Name: shop_feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_feedback_id_seq', 37, true);


--
-- Name: shop_hashtag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_hashtag_id_seq', 6, true);


--
-- Name: shop_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_order_id_seq', 42, true);


--
-- Name: shop_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_product_id_seq', 280, true);


--
-- Name: shop_ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_ticket_id_seq', 1, false);


--
-- Name: shop_ticket_response_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_ticket_response_id_seq', 1, false);


--
-- Name: shop_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_user_id_seq', 34, true);


--
-- Name: shop_auth shop_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_auth
    ADD CONSTRAINT shop_auth_pk PRIMARY KEY (id);


--
-- Name: shop_category shop_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_category
    ADD CONSTRAINT shop_category_pkey PRIMARY KEY (id);


--
-- Name: shop_feedback shop_feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_feedback
    ADD CONSTRAINT shop_feedback_pkey PRIMARY KEY (id);


--
-- Name: shop_tag shop_hashtag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_tag
    ADD CONSTRAINT shop_hashtag_pkey PRIMARY KEY (id);


--
-- Name: shop_order shop_order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_order
    ADD CONSTRAINT shop_order_pkey PRIMARY KEY (id);


--
-- Name: shop_order_product shop_order_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_order_product
    ADD CONSTRAINT shop_order_product_pkey PRIMARY KEY (product_id, order_id);


--
-- Name: shop_product_category shop_product_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_product_category
    ADD CONSTRAINT shop_product_category_pkey PRIMARY KEY (product_id, category_id);


--
-- Name: shop_product shop_product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_product
    ADD CONSTRAINT shop_product_pkey PRIMARY KEY (id);


--
-- Name: shop_product_tag shop_product_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_product_tag
    ADD CONSTRAINT shop_product_tag_pkey PRIMARY KEY (product_id, tag_id);


--
-- Name: shop_ticket shop_ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_ticket
    ADD CONSTRAINT shop_ticket_pkey PRIMARY KEY (id);


--
-- Name: shop_ticket_response shop_ticket_response_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_ticket_response
    ADD CONSTRAINT shop_ticket_response_pkey PRIMARY KEY (id);


--
-- Name: shop_user shop_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_user
    ADD CONSTRAINT shop_user_email_key UNIQUE (email);


--
-- Name: shop_user shop_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_user
    ADD CONSTRAINT shop_user_pkey PRIMARY KEY (id);


--
-- Name: shop_wish shop_wish_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_wish
    ADD CONSTRAINT shop_wish_pkey PRIMARY KEY (product_id, user_id);


--
-- Name: shop_feedback shop_feedback_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_feedback
    ADD CONSTRAINT shop_feedback_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.shop_product(id) ON DELETE CASCADE;


--
-- Name: shop_feedback shop_feedback_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_feedback
    ADD CONSTRAINT shop_feedback_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.shop_user(id) ON DELETE CASCADE;


--
-- Name: shop_order_product shop_order_product_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_order_product
    ADD CONSTRAINT shop_order_product_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.shop_order(id) ON DELETE CASCADE NOT VALID;


--
-- Name: shop_order_product shop_order_product_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_order_product
    ADD CONSTRAINT shop_order_product_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.shop_product(id) ON DELETE CASCADE;


--
-- Name: shop_order shop_order_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_order
    ADD CONSTRAINT shop_order_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.shop_user(id) ON DELETE CASCADE;


--
-- Name: shop_product_category shop_product_category_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_product_category
    ADD CONSTRAINT shop_product_category_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.shop_product(id) ON DELETE CASCADE;


--
-- Name: shop_product_category shop_product_category_shop_category_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_product_category
    ADD CONSTRAINT shop_product_category_shop_category_id_fk FOREIGN KEY (category_id) REFERENCES public.shop_category(id) ON DELETE CASCADE;


--
-- Name: shop_product_tag shop_product_tag_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_product_tag
    ADD CONSTRAINT shop_product_tag_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.shop_product(id) ON DELETE CASCADE;


--
-- Name: shop_product_tag shop_product_tag_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_product_tag
    ADD CONSTRAINT shop_product_tag_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.shop_tag(id) ON DELETE CASCADE;


--
-- Name: shop_ticket_response shop_ticket_response_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_ticket_response
    ADD CONSTRAINT shop_ticket_response_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.shop_ticket(id) ON DELETE CASCADE;


--
-- Name: shop_ticket shop_ticket_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_ticket
    ADD CONSTRAINT shop_ticket_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.shop_user(id) ON DELETE CASCADE;


--
-- Name: shop_wish shop_wish_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_wish
    ADD CONSTRAINT shop_wish_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.shop_product(id) ON DELETE CASCADE;


--
-- Name: shop_wish shop_wish_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shop_wish
    ADD CONSTRAINT shop_wish_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.shop_user(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

