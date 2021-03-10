use chat_box
go

create proc proc_crud_messengers
(
	@select int = null,

	@id int = null,
	@content nvarchar(20) = null,
	@times varchar(max) = null,
	@accounts_id int = null
)
as
begin

	if(@select = 1) -- insert
	begin
		insert into messengers
		(
			content,
			times,
			accounts_id
		) 
		values
		(
			@content,
			@times,
			@accounts_id
		)

		if(@@rowcount > 1) select 'insert'
	end

	if(@select = 2) -- update
	begin
		update messengers 
		set 
			content = @content,
			times = @times,
			accounts_id = @accounts_id
		where id = @id	

		if(@@rowcount > 1) select 'update'
	end

	if(@select = 3) -- delete 
	begin
		delete from messengers 
		where id = @id	

		select 'delete'
	end

	if(@select = 4) -- search by content 
	begin
		select *
		from messengers
		where content like '%'+@content+'%'

		if(@@rowcount > 1) select 'select completed'
	end

	if(@select = 5) -- search by times
	begin
		select *
		from messengers
		where times = @times

		if(@@rowcount > 1) select 'select completed'
	end
end
go