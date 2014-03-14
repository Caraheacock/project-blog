ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => (ENV['RACK_ENV'] == "test") ? "./app/databases/blog_test" : "./app/databases/blog"
)

ActiveRecord::Base.logger = Logger.new(STDERR)

# Create the tables and columns
ActiveRecord::Schema.define do
  unless ActiveRecord::Base.connection.tables.include? 'users'
    create_table :users do |table|
      table.column :username, :string
      table.column :password, :string
      table.column :first_name, :string
      table.column :last_name, :string
      table.column :email, :string
      table.column :facebook, :string
      table.column :twitter, :string
    end
  end

  unless ActiveRecord::Base.connection.tables.include? 'posts'
    create_table :posts do |table|
      table.column :user_id, :integer
      table.column :title, :string
      table.column :created_at, :datetime
      table.column :content, :text
    end
  end

  unless ActiveRecord::Base.connection.tables.include? 'comments'
    create_table :comments do |table|
      table.column :post_id, :integer
      table.column :commenter, :string
      table.column :email, :string
      table.column :content, :text
      table.column :created_at, :datetime
    end
  end
end

class User < ActiveRecord::Base
  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  
  # Takes the post content and creates an array of paragraphs.
  #
  # Returns an array where each paragraph is an item in the array.
  # def make_paragraphs(text)
  #   paragraphs = text.split(/n/n)
  # end
end

class Comment < ActiveRecord::Base
  belongs_to :post
end