use chat_box
go

create proc proc_crud_accounts 
(
	@select int = null,

	@id int = null,
	@names nvarchar(20) = null,
	@avatar varchar(max) = null
)
as
begin

	if(@select = 1) -- insert
	begin
		insert into accounts
		(
			names,
			avatar
		) 
		values
		(
			@names,
			@avatar
		)

		if(@@rowcount > 1) select 'insert'
	end

	if(@select = 2) -- update
	begin
		update accounts 
		set 
			names = @names,
			avatar = @avatar
		where id = @id	

		if(@@rowcount > 1) select 'update'
	end

	if(@select = 3) -- delete // account không chạy hàm delete
	begin
		delete from accounts 
		where id = @id	

		select 'delete'
	end

	if(@select = 4) -- search by name // account không chạy hàm search by name
	begin
		select *
		from accounts
		where names like '%'+@names+'%'

		if(@@rowcount > 1) select 'select completed'
	end

end
go