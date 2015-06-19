class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  		# adds unique index to user table 
  		# this is to make searching table easier 
  		# by allowing search by indexed email 
  		# instead of row-by-row comparing email
  		add_index :users, :email, unique: true
  end
end
