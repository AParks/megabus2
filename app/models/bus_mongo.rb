class BusMong 
	include MongoMapper::Document

	set_collection_name "buses"
    key :start_city, Integer
    key :end_city, Integer
    key :price, Integer

end