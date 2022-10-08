-- create database t_shirt_shop;
/* 
 * В данной работе произведена попытка разработки базы данных интернет магазина футболок с принтами и кличками собак
 * Задача: продавать кастомизируемые следующим образом футболки:
 * Пользователь выбирает на сайте категорию футболок (Мужские/Женские) далее
 * попадает на страницу товара, на которой выбирает цвет футболки, размер, породу собаки, цвет принта, указывает кличку животного и количество товара
 * ему на картинке должна кастомизироваться его футболка, далее добавляет позицию в корзину
 * В корзине делает оплату, о чем прилетает флаг в бд, далее со склада футболки в необходимом количестви списываются и отправляются в производство
 * В таблице производство можно отследить время заказа находящегощся в производстве, по окончании готовый товар передается в службу доставки
 * О чем делается флаг в таблице производства. Выводится сообщение о том, что футболка отправлена курьеров и номер заказа
 * Есть время отправки заказа, как только курьер доставит товар, ставится запись о времени когда был товар доставлен и флаг, что свидетельствует об окончании работы над заказом.
 * Также есть запрос на вывод курьеру информации о имени, адресе и телефона покупателя.
 */
set foreign_key_checks = 0;

drop table if exists users;
create table if not exists users (
	id serial primary key,
	name varchar (255) comment 'Имя',
	phone varchar(25) comment 'Телефон',
	address text comment 'Адрес',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)comment 'Покупатели' ;

insert into users(name, phone, address) values 
	('Никита', '+79051255544', 'Привольная 13к2'),
	('Валентина', '+79254475665', 'Строительная 15'),
	('Семен', '+79252231166', 'Мичуринский проспект 8'),
	('Кира', '+79166582133', 'Шелепихинское шоссе 16к2'),
	('Анастасия', '+79168743696', 'Проспект вернадского 151'),
	('Александр', '+79168743696', ' ул.Новодачная, д.4, кв.4'),
	('Эдуард', '+79168743696', 'ул.Еланского, д.97, кв.95'),
	('Екатерина', '+79168743696', 'ул.Сибиряковская, д.81, кв.32'),
	('Дмитрий', '+79168743696', 'ул.2-я Кабельная, д.1, кв.14'),
	('Павел', '+79168743696', 'ул.Неверовского, д.62, кв.100'),
	('Антон', '+79168743696', 'ул.Старослободская, д.42, кв.95'),
	('Елена', '+79168743696', 'ул.Сафоновская, д.63, кв.10');

drop table if exists t_shirts;
create table if not exists t_shirts (
	id serial primary key,
	category_id bigint unsigned not null,
	gender char(1),
	color char(6) comment 'Цвет футболки',
	price decimal (11,2) comment 'Цена',
	photo_t_id bigint unsigned not null comment 'Фото',
	`describe` text comment 'Описание',
	foreign key (photo_t_id) references photos_t(id),
	foreign key (category_id) references categories(id)
);

insert into t_shirts (category_id, gender, color, price, photo_t_id,  `describe`) values 
	(1, 'f', 'white', 1190, 1, 'Ничто так не предает уверенности, как твой верный спутник на твоей модной футболке. Разве нет?!
	Вы также можете заказать футболку только с изображением животного, или написать выдуманное имя, чтобы подчеркнуть свою индивидуальность, все в ваших руках.'),
	(1, 'f', 'pink', 1190, 1, 'Ничто так не предает уверенности, как твой верный спутник на твоей модной футболке. Разве нет?!
	Вы также можете заказать футболку только с изображением животного, или написать выдуманное имя, чтобы подчеркнуть свою индивидуальность, все в ваших руках.'),
	(2, 'm', 'white', 1190, 1, 'Ничто так не предает уверенности, как твой верный спутник на твоей модной футболке. Разве нет?!
	Вы также можете заказать футболку только с изображением животного, или написать выдуманное имя, чтобы подчеркнуть свою индивидуальность, все в ваших руках.'),
	(2, 'm', 'blue', 1190, 1, 'Ничто так не предает уверенности, как твой верный спутник на твоей модной футболке. Разве нет?!
	Вы также можете заказать футболку только с изображением животного, или написать выдуманное имя, чтобы подчеркнуть свою индивидуальность, все в ваших руках.');

drop table if exists categories;
create table if not exists categories (
	id serial primary key,
	t_shirt_id bigint unsigned not null,
	name varchar(255),
	foreign key (t_shirt_id) references t_shirt(id)
);

insert into categories (name, t_shirt_id) values 
('Женская футболка - Собаки', 1),
('Женская футболка - Собаки', 2),
('Мужская футболка - Собаки', 3),
('Мужская футболка - Собаки', 4);

drop table if exists sizes;
create table if not exists sizes(
	id serial primary key,
	t_shirt_id bigint unsigned not null,
	`size` char(2) comment 'Размер',
	foreign key (t_shirt_id) references t_shirt(id)
);

insert into `sizes` (t_shirt_id, `size`) values
	(1, 'XS'),
	(1, 'S'),
	(1, 'M'),
	(1, 'L'),
	(2, 'XS'),
	(2, 'S'),
	(2, 'M'),
	(2, 'L'),
	(3, 'M'),
	(3, 'L'),
	(3, 'XL'),
	(4, 'M'),
	(4, 'L'),
	(4, 'XL');

drop table if exists photos_t;
create table if not exists photos_t (
	id serial primary key,
	t_shirt_id bigint unsigned not null,
	name varchar(255),
	foreign key (t_shirt_id) references t_shirt(id)
);

insert into photos_t (t_shirt_id, name) values
	(1, 'female_white.jpeg'),
	(2, 'female_pink.jpeg'),
	(3, 'male_white.jpeg'),
	(4, 'male_blue.jpeg');
	
drop table if exists breeds;
create table if not exists breeds (
	id serial primary key,
	t_shirt_id bigint unsigned not null,
	link_photo varchar(255),
	name_breed varchar(255),
	print_color char(6) comment 'Цвет принта',
	foreign key (t_shirt_id) references t_shirt(id)
);

insert into breeds(t_shirt_id, link_photo, name_breed, print_color) values 
	(1, 'dog1.jpeg', 'Акита', 'white'),
	(1, 'dog2.jpeg', 'Афганская Борзая', 'white'),
	(1, 'dog3.jpeg', 'Бассет-Хаунд', 'white'),
	(1, 'dog4.jpeg', 'Бигль', 'white'),
	(1, 'dog5.jpeg', 'Бишон-фризе', 'white'),
	(1, 'dog6.jpeg', 'Босерон', 'white'),
	(1, 'dog7.jpeg', 'Веймаанер', 'white'),
	(1, 'dog8.jpeg', 'Джек рассел', 'white'),
	(1, 'dog9.jpeg', 'Золотой ретривер', 'white'),
	(1, 'dog10.jpeg', 'Колли', 'white'),
	(1, 'dog11.jpeg', 'Лабрадор', 'white'),
	(1, 'dog12.jpeg', 'Маламут', 'white'),
	(1, 'dog13.jpeg', 'Ньюфауленд', 'white'),
	(1, 'dog14.jpeg', 'Поинтер', 'white'),
	(1, 'dog15.jpeg', 'Самоед', 'white'),
	(1, 'dog16.jpeg', 'Такса', 'white'),
	(1, 'dog17.jpeg', 'Акита', 'black'),
	(1, 'dog18.jpeg', 'Афганская Борзая', 'black'),
	(1, 'dog19.jpeg', 'Бассет-Хаунд', 'black'),
	(1, 'dog20.jpeg', 'Бигль', 'black'),
	(1, 'dog21.jpeg', 'Бишон-фризе', 'black'),
	(1, 'dog22.jpeg', 'Босерон', 'black'),
	(1, 'dog23.jpeg', 'Веймаанер', 'black'),
	(1, 'dog24.jpeg', 'Джек рассел', 'black'),
	(1, 'dog25.jpeg', 'Золотой ретривер', 'black'),
	(1, 'dog26.jpeg', 'Колли', 'black'),
	(1, 'dog27.jpeg', 'Лабрадор', 'black'),
	(1, 'dog28.jpeg', 'Маламут', 'black'),
	(1, 'dog29.jpeg', 'Ньюфауленд', 'black'),
	(1, 'dog30.jpeg', 'Поинтер', 'black'),
	(1, 'dog31.jpeg', 'Самоед', 'black'),
	(1, 'dog32.jpeg', 'Такса', 'black'),
	(2, 'dog1.jpeg', 'Акита', 'white'),
	(2, 'dog2.jpeg', 'Афганская Борзая', 'white'),
	(2, 'dog3.jpeg', 'Бассет-Хаунд', 'white'),
	(2, 'dog4.jpeg', 'Бигль', 'white'),
	(2, 'dog5.jpeg', 'Бишон-фризе', 'white'),
	(2, 'dog6.jpeg', 'Босерон', 'white'),
	(2, 'dog7.jpeg', 'Веймаанер', 'white'),
	(2, 'dog8.jpeg', 'Джек рассел', 'white'),
	(2, 'dog9.jpeg', 'Золотой ретривер', 'white'),
	(2, 'dog10.jpeg', 'Колли', 'white'),
	(2, 'dog11.jpeg', 'Лабрадор', 'white'),
	(2, 'dog12.jpeg', 'Маламут', 'white'),
	(2, 'dog13.jpeg', 'Ньюфауленд', 'white'),
	(2, 'dog14.jpeg', 'Поинтер', 'white'),
	(2, 'dog15.jpeg', 'Самоед', 'white'),
	(2, 'dog16.jpeg', 'Такса', 'white'),
	(2, 'dog17.jpeg', 'Акита', 'black'),
	(2, 'dog18.jpeg', 'Афганская Борзая', 'black'),
	(2, 'dog19.jpeg', 'Бассет-Хаунд', 'black'),
	(2, 'dog20.jpeg', 'Бигль', 'black'),
	(2, 'dog21.jpeg', 'Бишон-фризе', 'black'),
	(2, 'dog22.jpeg', 'Босерон', 'black'),
	(2, 'dog23.jpeg', 'Веймаанер', 'black'),
	(2, 'dog24.jpeg', 'Джек рассел', 'black'),
	(2, 'dog25.jpeg', 'Золотой ретривер', 'black'),
	(2, 'dog26.jpeg', 'Колли', 'black'),
	(2, 'dog27.jpeg', 'Лабрадор', 'black'),
	(2, 'dog28.jpeg', 'Маламут', 'black'),
	(2, 'dog29.jpeg', 'Ньюфауленд', 'black'),
	(2, 'dog30.jpeg', 'Поинтер', 'black'),
	(2, 'dog31.jpeg', 'Самоед', 'black'),
	(2, 'dog32.jpeg', 'Такса', 'black'),
	(3, 'dog1.jpeg', 'Акита', 'white'),
	(3, 'dog2.jpeg', 'Афганская Борзая', 'white'),
	(3, 'dog3.jpeg', 'Бассет-Хаунд', 'white'),
	(3, 'dog4.jpeg', 'Бигль', 'white'),
	(3, 'dog5.jpeg', 'Бишон-фризе', 'white'),
	(3, 'dog6.jpeg', 'Босерон', 'white'),
	(3, 'dog7.jpeg', 'Веймаанер', 'white'),
	(3, 'dog8.jpeg', 'Джек рассел', 'white'),
	(3, 'dog9.jpeg', 'Золотой ретривер', 'white'),
	(3, 'dog10.jpeg', 'Колли', 'white'),
	(3, 'dog11.jpeg', 'Лабрадор', 'white'),
	(3, 'dog12.jpeg', 'Маламут', 'white'),
	(3, 'dog13.jpeg', 'Ньюфауленд', 'white'),
	(3, 'dog14.jpeg', 'Поинтер', 'white'),
	(3, 'dog15.jpeg', 'Самоед', 'white'),
	(3, 'dog16.jpeg', 'Такса', 'white'),
	(3, 'dog17.jpeg', 'Акита', 'black'),
	(3, 'dog18.jpeg', 'Афганская Борзая', 'black'),
	(3, 'dog19.jpeg', 'Бассет-Хаунд', 'black'),
	(3, 'dog20.jpeg', 'Бигль', 'black'),
	(3, 'dog21.jpeg', 'Бишон-фризе', 'black'),
	(3, 'dog22.jpeg', 'Босерон', 'black'),
	(3, 'dog23.jpeg', 'Веймаанер', 'black'),
	(3, 'dog24.jpeg', 'Джек рассел', 'black'),
	(3, 'dog25.jpeg', 'Золотой ретривер', 'black'),
	(3, 'dog26.jpeg', 'Колли', 'black'),
	(3, 'dog27.jpeg', 'Лабрадор', 'black'),
	(3, 'dog28.jpeg', 'Маламут', 'black'),
	(3, 'dog29.jpeg', 'Ньюфауленд', 'black'),
	(3, 'dog30.jpeg', 'Поинтер', 'black'),
	(3, 'dog31.jpeg', 'Самоед', 'black'),
	(3, 'dog32.jpeg', 'Такса', 'black'),
	(4, 'dog1.jpeg', 'Акита', 'white'),
	(4, 'dog2.jpeg', 'Афганская Борзая', 'white'),
	(4, 'dog3.jpeg', 'Бассет-Хаунд', 'white'),
	(4, 'dog4.jpeg', 'Бигль', 'white'),
	(4, 'dog5.jpeg', 'Бишон-фризе', 'white'),
	(4, 'dog6.jpeg', 'Босерон', 'white'),
	(4, 'dog7.jpeg', 'Веймаанер', 'white'),
	(4, 'dog8.jpeg', 'Джек рассел', 'white'),
	(4, 'dog9.jpeg', 'Золотой ретривер', 'white'),
	(4, 'dog10.jpeg', 'Колли', 'white'),
	(4, 'dog11.jpeg', 'Лабрадор', 'white'),
	(4, 'dog12.jpeg', 'Маламут', 'white'),
	(4, 'dog13.jpeg', 'Ньюфауленд', 'white'),
	(4, 'dog14.jpeg', 'Поинтер', 'white'),
	(4, 'dog15.jpeg', 'Самоед', 'white'),
	(4, 'dog16.jpeg', 'Такса', 'white'),
	(4, 'dog17.jpeg', 'Акита', 'black'),
	(4, 'dog18.jpeg', 'Афганская Борзая', 'black'),
	(4, 'dog19.jpeg', 'Бассет-Хаунд', 'black'),
	(4, 'dog20.jpeg', 'Бигль', 'black'),
	(4, 'dog21.jpeg', 'Бишон-фризе', 'black'),
	(4, 'dog22.jpeg', 'Босерон', 'black'),
	(4, 'dog23.jpeg', 'Веймаанер', 'black'),
	(4, 'dog24.jpeg', 'Джек рассел', 'black'),
	(4, 'dog25.jpeg', 'Золотой ретривер', 'black'),
	(4, 'dog26.jpeg', 'Колли', 'black'),
	(4, 'dog27.jpeg', 'Лабрадор', 'black'),
	(4, 'dog28.jpeg', 'Маламут', 'black'),
	(4, 'dog29.jpeg', 'Ньюфауленд', 'black'),
	(4, 'dog30.jpeg', 'Поинтер', 'black'),
	(4, 'dog31.jpeg', 'Самоед', 'black'),
	(4, 'dog32.jpeg', 'Такса', 'black');

drop table if exists payed_orders;
create table if not exists payed_orders (
	id serial primary key,
  	user_id bigint unsigned not null,
  	order_product_id bigint unsigned not null,
  	summ_order decimal (11,2),
  	check_at_storehouse boolean,
  	check_at_prodaction boolean,
  	check_on_delivery boolean,
  	from_storehouse bigint not null default 0,
  	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  	foreign key (user_id) references users(id),
  	foreign key (order_product_id) references order_product(id)
);

drop table if exists order_product;
create table if not exists order_product (
	id serial primary key,
	category_name varchar(255),
	order_num bigint,
	user_id bigint unsigned not null,
	t_shirt_id bigint unsigned not null,
	size_id bigint unsigned not null,
	breed_id bigint unsigned not null,
	quantity bigint comment 'Количество при заказе',
	pet_name varchar(16) comment 'кличка животного',
	pay boolean default false,
	price decimal (11,2),
  	check_at_storehouse boolean default true,
  	check_at_prodaction boolean default false,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  	foreign key (user_id) references users(id),
  	foreign key (t_shirt_id) references t_shirts(id),
  	foreign key (size_id) references sizes(id),
  	foreign key (breed_id) references breeds(id)
);

drop table if exists storehouse_t_shirts;
create table if not exists storehouse_t_shirts (
	id serial primary key,
	t_shirt_id bigint unsigned not null,
	value bigint,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  	foreign key (t_shirt_id) references t_shirts(id)
);

insert into storehouse_t_shirts (t_shirt_id, value) values -- заполним склад мужскими/женскими футболками разных цветов
	(1, 234),
	(2, 118),
	(3, 180),
	(4, 301);

drop table if exists order_in_production;
create table if not exists order_in_production(
id serial primary key,
payed_order_id bigint unsigned not null,
to_production bigint,
to_delivery boolean default false,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
foreign key (payed_order_id) references order_product(id) on delete cascade
);

drop table if exists order_on_delivery;
create table if not exists order_on_delivery (
id serial primary key,
order_num bigint,
sended_at DATETIME,
deliveried_at DATETIME,
deliveried boolean,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


set @catecory_click:=1; -- пользователь выбрал страницу товара 1 категории - женские футболки, для мужской категории - 2

-- выведем все данные для страницы товара 1(2) категории (цвета футболок, породы собак, цвета принтов, размеры со стороны сайта будут спрятаны в всплывающие списки)
select c.name, b.print_color, b.name_breed, t.gender, t.color, t.price, s.`size`, t.`describe` from t_shirts t
join categories c on c.id=t.category_id
join sizes s on s.t_shirt_id=t.id
join breeds b on b.t_shirt_id=t.id
where c.id=@catecory_click;


-- процедура для добавления товара в корзину, пользователь на странице товара выбирает цвет футболки, размер, породу собаки, цвет принта, количество футболок, кличку животного, 
-- далее айди юзера, и выбранные им живые параметры с сайта подаются на вход в процедуру и процедура делает запись в таблице неоплаченных товаров но уже с id данных параметров.
drop procedure if exists `insert_to_order`;

delimiter //
create procedure `insert_to_order` (user_id bigint, genders char(1), colors char(6), size_n char(2), breed_n varchar(255), print_c char(6), quantity bigint,  pet_name varchar(16), order_nums bigint)
	begin
		insert into order_product(user_id, t_shirt_id, size_id, breed_id, quantity, price, pet_name, category_name, order_num) values 
			(user_id, 
			(select id from t_shirts where color=colors and gender=genders), 
			(select id from sizes where `size`=size_n and t_shirt_id in (select id from t_shirts where color=colors and gender=genders)), 
			(select id from breeds where name_breed = breed_n and print_color = print_c and t_shirt_id in (select id from t_shirts where color=colors and gender=genders)),
			quantity,
			(quantity*(select price from t_shirts where id in (select id from t_shirts where color=colors and gender=genders))),
			pet_name,
			(select name from categories where t_shirt_id in (select id from t_shirts where color=colors and gender=genders)),
			order_nums
			);
	end
delimiter ;


-- добавим заказы от разных пользователей
call `insert_to_order` (1, 'f', 'white', 'S', 'Акита', 'white', 3, 'Нотка', 463);
call `insert_to_order` (1, 'f', 'pink', 'S', 'Ньюфауленд', 'black', 2, 'Джесси', 463);
call `insert_to_order` (2, 'm', 'blue', 'M', 'Бигль', 'black', 3, 'Сима', 346);
call `insert_to_order` (3, 'f', 'white', 'XS', 'Джек рассел', 'white', 1, 'Луша', 865);
call `insert_to_order` (4, 'f', 'pink', 'S', 'Поинтер', 'black', 2, 'Дюна', 230);
call `insert_to_order` (5, 'm', 'white', 'M', 'Босерон', 'black', 5, 'Пит', 711);
call `insert_to_order` (5, 'f', 'white', 'M', 'Такса', 'white', 1, 'Балли', 711);
call `insert_to_order` (5, 'f', 'pink', 'S', 'Колли', 'black', 2, 'Саймон', 711);
call `insert_to_order` (3, 'm', 'white', 'XL', 'Золотой ретривер', 'black', 3, 'Ричард', 865);
call `insert_to_order` (7, 'm', 'white', 'L', 'Самоед', 'white', 4, 'Баська', 877);
call `insert_to_order` (8, 'm', 'blue', 'L', 'Маламут', 'black', 2, 'Рей', 321);
call `insert_to_order` (9, 'f', 'pink', 'L', 'Лабрадор', 'black', 3, 'Сема', 999);



-- корзина пользователя
-- процедура для вывода данных по заказам пользователя, которые еще не оплачены

drop procedure if exists cart;
delimiter //
create procedure cart (users_id bigint)
begin
		select op.order_num as 'Номер заказа', op.category_name 'Категория', op.pet_name as 'Кличка', b.name_breed as 'Порода', s.`size` as 'Размер', ts.color as 'Цвет', quantity as 'Кол-во' , ts.price*quantity  as 'Цена' from order_product op
		join sizes s on s.id=op.size_id
		join t_shirts ts on ts.id=op.t_shirt_id 
		join breeds b on b.id=op.breed_id 
		where op.id in (select op.id from order_product op where user_id=users_id);
end
delimiter ;

-- вывод корзины разных пользователей
call cart(1);
call cart(2);
call cart(3);
call cart(4);
call cart(5);
call cart(7);
call cart(8);
call cart(9);

select order_num, sum(price) from order_product op group by order_num; -- сумма всего заказа по номеру заказа

select * from order_product op where pay = false; -- всего заказов, и позиции заказов, которые еще не оплачены



-- провести оплату от 1,3,5,7,8 пользователя 
set @pay_confirmed_id:=3; 
update order_product 	  
set pay = true
where user_id = @pay_confirmed_id; -- 1,3,5,7,8

-- поставить флаг в таблице заказов о том, что товар забрали со склада
set @from_storehouse=true;
update order_product
set check_at_storehouse = case 
							when @from_storehouse=true 
							then false 
							else true 
							end
where pay=true;

-- данный запрос показывает пол футболки и цвет которые заказал пользователь
select id, gender, category_id, color from t_shirts ts where id in (select t_shirt_id from order_product op where pay=true and user_id = @pay_confirmed_id);


-- данный запрос списывает количество заказанных футболок со склада, которые заказал человек (надо вводить пол и цвет футболки, чтобы списывалось с конкретной футболки, если человек заказал две разные)
update storehouse_t_shirts 
set value = value - (select quantity from order_product where pay=true and user_id = @pay_confirmed_id and t_shirt_id in (select id from t_shirts ts2 where gender = 'f' and color = 'white'))
where t_shirt_id in (select id from t_shirts ts2 where gender = 'f' and color = 'white');



-- тригер срабатывает, когда со склада уходит футболка, данная футболку по номеру заказа добавляется в таблицу производство order_in_production
drop trigger if exists go_to_prodaction;
delimiter //
create trigger go_to_prodaction before update on order_product
	for each row 
	begin 
		if (new.check_at_storehouse=false) then 
		set new.check_at_prodaction = true;
		insert into order_in_production(payed_order_id, to_production) values (new.id, old.quantity);
	end if;
end
delimiter ;

-- данный запрос покажет сколько времени в производстве находится заказ, пока он не отправлен в доставку
select @order_num as 'Номер заказа', TIMEDIFF(current_timestamp(),created_at) 'Времени в производстве' from order_in_production where to_delivery = false;
-- Вывести Название футболки и количество, находящегося в производстве по номеру полученного в запросе ранее заказе
set @order_num:=865;
select category_name as 'Название', quantity as 'Количество' from order_product where order_num = @order_num;


-- Ответственный за производство работник передает готовый товар курьеру.
set @order_num:=865; -- можно передать еще 865, 463
-- Запрос обновляет флаг в таблице производство на то, что товар передан в доставку
update order_in_production	  
set to_delivery = true 
where payed_order_id in (select id from order_product where order_num = @order_num);

-- процедура для добавления записи о том, во сколько отправлен заказ и номер заказа в таблицу order_on_delivery
drop procedure if exists `insert_to_delivery`;

delimiter //
create procedure `insert_to_delivery` (order_nums bigint)
	begin
		insert into order_on_delivery(order_num, sended_at) values 
			(order_nums, current_timestamp());
	end
delimiter ;

-- передали товар курьеру
call insert_to_delivery(@order_num);

-- Выводим сообщение о том, что товар передан курьеру
set @order_num:=865;
select case 
		when to_delivery=true then 'Ваш товар передан курьеру'
		end as 'Message'
from order_in_production where payed_order_id in (select id from order_product op where order_num=@order_num) group by 'Message';


-- процедура для курьера, когда он доставил товар, то делается запись времени и флаг в таблице order_on_delivery

drop procedure if exists `delivered`;
delimiter //
create procedure `delivered` (order_num bigint)
	begin
		update order_on_delivery
		set deliveried_at = current_timestamp(),
			deliveried = true;
	end
delimiter ;

-- поставим отметку о том, что товар доставлен
call delivered(@order_num);


-- Выведем информацию для курьера, номер заказа, адрер, имя и телефон покупателя
select name, address, phone, @order_num as 'Номер заказа' from users where id in (select user_id from order_product op where order_num = @order_num group by user_id);
