use chat_box
go

create table accounts
(
	id int identity(1, 1) primary key not null,
	names nvarchar(20),
	avatar varchar (max)
)
go

create table messengers
(
	id int identity(1, 1) primary key not null,
	content nvarchar(max),
	times datetime,

	accounts_id int 

	constraint fk_messengers_accounts
	foreign key (accounts_id) references accounts (id)
)
go