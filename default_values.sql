create TYPE status_enum AS ENUM('OPEN', 'ORDERED')

create table if not exists carts (
	id uuid primary key default uuid_generate_v4(),
	user_id uuid not null,
	create_at date not null,
	updated_at date not null,
	status status_enum
)

create table if not exists cart_items (
	cart_id uuid,
	product_id uuid,
	count int,
	foreign key ("cart_id") references "carts" ("id")
)

create table if not exists orders (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null,
  cart_id uuid not null,
  payment JSON not null,
  delivery JSON not null,
  comments text not null,
  status text not null,
  total numeric not null,
  foreign key ("cart_id") references "carts"
)

INSERT INTO orders (user_id, cart_id, payment, delivery, comments, status, total)
VALUES
  ('1ba4c819-46d1-4d75-92e8-836cc52fd0c7', '7ba7af0b-dc44-49de-a8a8-fabffcf5d058', '{"type": "credit card", "number": "4111111111111111", "expiry": "12/2025", "cvv": "123"}', '{"address": "123 Main St", "city": "Anytown", "state": "CA", "zip": "12345"}', 'No comments', 'PENDING', 200.50),
  ('2d335a01-845a-412c-9c2a-e1c48a37b46a', '26335d36-8dbc-4418-8e67-0dffe7e55d4a', '{"type": "paypal", "account": "user@example.com"}', '{"address": "", "city": "", "state": "", "zip": ""}', 'Fast delivery requested', 'SHIPPED', 500.00)

create extension if not exists "uuid-ossp"

INSERT INTO carts (user_id, create_at, updated_at, status) VALUES ('d14948df-10fd-4c9b-9ce7-a172ded73eef', NOW(), NOW(), 'OPEN')

INSERT INTO carts (user_id, create_at, updated_at, status) VALUES ('d14948df-10fd-4c9b-9ce7-a172ded73eef', NOW(), NOW(), 'ORDERED')

insert  into cart_items (cart_id, product_id, count) values ('3fe85486-5b43-4851-8071-98e19db05d29', '8e115e6c-e57b-46cc-9957-b7a0fb839331' ,20)

insert into cart_items (cart_id, product_id, count) values ('3fe85486-5b43-4851-8071-98e19db05d29', '5258ad21-c3ec-482a-9f2a-525268dd94e3',  10)