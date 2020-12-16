insert into public.shop_category (id, name) values (1, 'Campagna');
insert into public.shop_category (id, name) values (2, 'Decorazioni Natalizie');
insert into public.shop_category (id, name) values (3, 'Utensili');
insert into public.shop_category (id, name) values (4, 'Bevande');

insert into public.shop_tag (id, hashtag) values (1, '#sconti');
insert into public.shop_tag (id, hashtag) values (2, '#natale');
insert into public.shop_tag (id, hashtag) values (3, '#babbonatale');
insert into public.shop_tag (id, hashtag) values (4, '#solfato');

insert into public.shop_user (id, email, password, status, role, name, surname, gender, phone, birth, created_at, updated_at) values (1, 'admin@test.com', '123                                                                                                                             ', 0, 1, 'Admin', 'Prova', 1, '12345678', '2020-12-15', '2020-12-15 23:06:01.268677', '2020-12-15 23:06:01.268677');
insert into public.shop_user (id, email, password, status, role, name, surname, gender, phone, birth, created_at, updated_at) values (2, 'user@test.com', '123                                                                                                                             ', 0, 0, 'Utente', 'Prova', 2, '12345678', '2020-12-15', '2020-12-15 23:06:01.268677', '2020-12-15 23:06:01.268677');
insert into public.shop_user (id, email, password, status, role, name, surname, gender, phone, birth, created_at, updated_at) values (3, 'simona.perri@ai.com', '123                                                                                                                             ', 0, 1, 'Simona', 'Perri', 1, '12345678', '2020-12-15', '2020-12-15 23:06:01.268677', '2020-12-15 23:06:01.268677');
insert into public.shop_user (id, email, password, status, role, name, surname, gender, phone, birth, created_at, updated_at) values (4, 'ciccio.ricca@gmail.com', '123                                                                                                                             ', 0, 0, 'Ciccio', 'Ricca', 2, '12345678', '2020-12-15', '2020-12-15 23:06:01.268677', '2020-12-15 23:06:01.268677');

insert into public.shop_order (id, user_id, status, created_at, updated_at) values (1, 1, 0, '2021-12-16 00:27:08.000000', '2020-12-16 00:27:17.000000');
insert into public.shop_order (id, user_id, status, created_at, updated_at) values (2, 2, 1, '2020-12-16 00:27:13.000000', '2020-12-16 00:27:18.000000');
insert into public.shop_order (id, user_id, status, created_at, updated_at) values (3, 3, 0, '2020-12-16 00:27:15.000000', '2020-12-16 00:27:19.000000');
insert into public.shop_order (id, user_id, status, created_at, updated_at) values (4, 4, 0, '2020-12-16 00:27:16.000000', '2020-12-16 00:27:20.000000');

insert into public.shop_product (id, name, description, price, stock, status, updated_at, created_at) values (1, 'Solfato Di Ferro', 'Questa è una descrizione', 1.2, 999, 0, '2020-12-15 23:19:11.380551', '2020-12-15 23:19:11.380551');
insert into public.shop_product (id, name, description, price, stock, status, updated_at, created_at) values (2, 'Albero di Natale', 'Questa è una descrizione', 133.2, 90, 0, '2020-12-15 23:19:11.380551', '2020-12-15 23:19:11.380551');
insert into public.shop_product (id, name, description, price, stock, status, updated_at, created_at) values (3, 'Presepe', 'Questa è una descrizione', 31.2, 999, 0, '2020-12-15 23:19:11.380551', '2020-12-15 23:19:11.380551');
insert into public.shop_product (id, name, description, price, stock, status, updated_at, created_at) values (4, 'Zappa', 'Questa è una descrizione', 999, 2, 0, '2020-12-15 23:19:11.380551', '2020-12-15 23:19:11.380551');

insert into public.shop_feedback (id, title, description, vote, product_id, created_at, updated_at, user_id) values (1, 'Belloooo', 'Questa è una descrizione', 5.5, 1, '2020-12-15 23:32:53.391889', '2020-12-15 23:32:53.391889', 1);
insert into public.shop_feedback (id, title, description, vote, product_id, created_at, updated_at, user_id) values (2, 'Ottimo prodotto', 'Questa è una descrizione', 5.5, 2, '2020-12-15 23:32:53.391889', '2020-12-15 23:32:53.391889', 2);
insert into public.shop_feedback (id, title, description, vote, product_id, created_at, updated_at, user_id) values (3, 'Sono stato derubato', 'Questa è una descrizione', 5.5, 3, '2020-12-15 23:32:53.391889', '2020-12-15 23:32:53.391889', 3);
insert into public.shop_feedback (id, title, description, vote, product_id, created_at, updated_at, user_id) values (4, 'Una merda!!!!!!', 'Questa è una descrizione', 9.5, 4, '2020-12-15 23:32:53.391889', '2020-12-15 23:32:53.391889', 4);

insert into public.shop_ticket (id, title, description, status, user_id, created_at, updated_at) values (1, 'Richiesta info', 'Questa è una descrizione', 0, 1, '2020-12-15 23:24:05.509971', '2020-12-15 23:24:05.509971');
insert into public.shop_ticket (id, title, description, status, user_id, created_at, updated_at) values (2, 'Richiesta aiuto', 'Questa è una descrizione', 1, 2, '2020-12-15 23:24:05.509971', '2020-12-15 23:24:05.509971');
insert into public.shop_ticket (id, title, description, status, user_id, created_at, updated_at) values (3, 'Richiesta assistenza', 'Questa è una descrizione', 0, 3, '2020-12-15 23:24:05.509971', '2020-12-15 23:24:05.509971');
insert into public.shop_ticket (id, title, description, status, user_id, created_at, updated_at) values (4, 'Richiesta info', 'Questa è una descrizione', 0, 4, '2020-12-15 23:24:05.509971', '2020-12-15 23:24:05.509971');

insert into public.shop_ticket_response (id, response, created_at, updated_at, ticket_id) values (1, 'Questa è una risposta', '2020-12-15 23:25:01.421234', '2020-12-15 23:25:01.421234', 1);
insert into public.shop_ticket_response (id, response, created_at, updated_at, ticket_id) values (2, 'Questa è una risposta', '2020-12-15 23:25:01.421234', '2020-12-15 23:25:01.421234', 2);
insert into public.shop_ticket_response (id, response, created_at, updated_at, ticket_id) values (3, 'Questa è una risposta', '2020-12-15 23:25:01.421234', '2020-12-15 23:25:01.421234', 3);
insert into public.shop_ticket_response (id, response, created_at, updated_at, ticket_id) values (4, 'Questa è una risposta', '2020-12-15 23:25:01.421234', '2020-12-15 23:25:01.421234', 4);

insert into public.shop_transaction (id, status, created_at, updated_at, result, total, type, courier_service, shipment_number, weight, recipient, address, city, province, zip, phone, additional_info, invoice, order_id, transaction_code) values (2, 1, '2020-12-15 23:42:28.605014', '2020-12-15 23:42:28.605014', '{}', 100, 1, 'Bartolini', 'AA9887643756                                                    ', 1, 'Ciccio Ricca', 'Via G.Marconi 59/u', 'Joppolo', 'Vibo Valentia', '89855', '3267746768', 'Informazioni Addizionali', '12133', 1, '1111');
insert into public.shop_transaction (id, status, created_at, updated_at, result, total, type, courier_service, shipment_number, weight, recipient, address, city, province, zip, phone, additional_info, invoice, order_id, transaction_code) values (3, 0, '2020-12-15 23:42:28.605014', '2020-12-15 23:42:28.605014', '{}', 97, 0, 'Posta', 'AA9887641111                                                    ', 3, 'Simona Perri', 'Via J.F.Kennedy 5/u', 'Rosarno', 'Vibo Valentia', '89888', '3267746768', 'Informazioni Addizionali', '12434', 2, '1232');
insert into public.shop_transaction (id, status, created_at, updated_at, result, total, type, courier_service, shipment_number, weight, recipient, address, city, province, zip, phone, additional_info, invoice, order_id, transaction_code) values (4, 0, '2020-12-15 23:42:28.605014', '2020-12-15 23:42:28.605014', '{}', 88, 2, 'SDA', 'AA9887643456                                                    ', 5, 'User Prova', 'Via G.DelMare 59/u', 'San Ferdinando', 'Reggio Calabria', '89844', '3267746768', 'Informazioni Addizionali', '42545', 3, '2132');
insert into public.shop_transaction (id, status, created_at, updated_at, result, total, type, courier_service, shipment_number, weight, recipient, address, city, province, zip, phone, additional_info, invoice, order_id, transaction_code) values (5, 1, '2020-12-15 23:42:28.605014', '2020-12-15 23:42:28.605014', '{}', 100, 0, 'GLS', 'AA9887643222                                                    ', 7, 'User NonProva', 'Via Sayonara', 'Casette', 'Vibo Valentia', '89877', '3267746768', 'Informazioni Addizionali', '45747', 4, null);

insert into public.shop_product_category (product_id, category_id) values (1, 1);
insert into public.shop_product_category (product_id, category_id) values (2, 2);
insert into public.shop_product_category (product_id, category_id) values (3, 3);
insert into public.shop_product_category (product_id, category_id) values (4, 4);

insert into public.shop_order_product (product_id, order_id, quantity) values (1, 1, 12);
insert into public.shop_order_product (product_id, order_id, quantity) values (2, 2, 1);
insert into public.shop_order_product (product_id, order_id, quantity) values (3, 3, 2);
insert into public.shop_order_product (product_id, order_id, quantity) values (4, 4, 3);
insert into public.shop_order_product (product_id, order_id, quantity) values (3, 2, 55);
insert into public.shop_order_product (product_id, order_id, quantity) values (4, 3, 4);
insert into public.shop_order_product (product_id, order_id, quantity) values (3, 1, 3);
insert into public.shop_order_product (product_id, order_id, quantity) values (4, 2, 22);

insert into public.shop_product_tag (product_id, tag_id) values (1, 1);
insert into public.shop_product_tag (product_id, tag_id) values (2, 2);
insert into public.shop_product_tag (product_id, tag_id) values (3, 3);
insert into public.shop_product_tag (product_id, tag_id) values (4, 4);

insert into public.shop_wish (product_id, user_id) values (1, 1);
insert into public.shop_wish (product_id, user_id) values (2, 2);
insert into public.shop_wish (product_id, user_id) values (3, 3);
insert into public.shop_wish (product_id, user_id) values (4, 4);







