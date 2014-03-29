def map_data
	require "sqlite3"
	db = SQLite3::Database.new "../../../data/ghost-dev.db"
	posts = []
	db.execute( "select * from posts where status = 'published' " ) do |row|
	  new_row = {}
	  new_row['id']               = row[0]
	  new_row['uuid']             = row[1]
	  new_row['title']            = row[2]
	  new_row['slug']             = row[3]
	  new_row['markdown']         = row[4]
	  new_row['hmtl']             = row[5]
	  new_row['image']            = row[6]
	  new_row['featured']         = row[7]
	  new_row['page']             = row[8]
	  new_row['status']           = row[9]
	  new_row['language']         = row[10]
	  new_row['meta_title']       = row[11]
	  new_row['meta_description'] = row[12]
	  new_row['author_id']        = row[13]
	  new_row['created_at']       = row[14]
	  new_row['created_by']       = row[15]
	  new_row['updated_at']       = row[16]
	  new_row['updated_by']       = row[17]
	  new_row['published_at']     = row[18]
	  new_row['published_by']     = row[19]
	  posts << new_row
	end

	posts
end