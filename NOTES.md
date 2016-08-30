1. I need users
  URLs
    GET /signup #=> see a form
    POST /users #=> actually create the user
  database
    I need a users table to store their email and password
    * See 1.b
2. I need to give users passwords
3. Make sure I can find user with their actual password
4. Change my login system to use their email and password to authenticate

1.b
A. In terminal => rake db:create_migration NAME=create_users
B. In newly created "create_users" file in db/migrate:
  class CreateUsers < ActiveRecord::Migration
    def change
      create_table :users do |t|
        t.string :email
      end
    end
  end
C. Create app/models/user.rb file
D. In user.rb file:
  class User < ActiveRecord::Base
  end
E. In terminal => rake db:migrate
F. In terminal => rake console
G. In rake console # test that model and db work correctly:
  User.create(:email => "kerry@email.com")
    => #<User:0x007ff5e14e99c0 id: 1, email: "kerry@email.com">
H. In Gemfile: add gem 'bcrypt'
I. In terminal => rake db:create_migration NAME=add_passwords_to_users
J. In newly created "add_passwords_to_users" file:
  class AddPasswordsToUsers < ActiveRecord::Migration
    def change
      add_column :users, :password_digest, :string
    end
  end
K. In terminal => rake db:migrate
L. In app/models/user.rb =>
  class User < ActiveRecord::Base
    has_secure_password
  end
M. In terminal => rake console
N. In rake console =>
  u = User.new
  u.password = "hello"
  u.email = "hello@example.com"
  u.save
  u
    => #<User:0x007fbb8b0ab448 id: 2, email: "hello@example.com", password_digest: "$2a$10$19RSQjgq9iu75e4F.gCSQefWojqBPHexv45VndYPz3lq7PZYJQkXC">
O. exit, then restart rake console:
  u = User.find_by(:email => "hello@example.com")
    => #<User:0x007ff9329abce8 id: 2, email: "hello@example.com", password_digest: "$2a$10$19RSQjgq9iu75e4F.gCSQefWojqBPHexv45VndYPz3lq7PZYJQkXC">
  u.password
    => nil
  u.authenticate("hello")
    => #<User:0x007ff9329abce8 id: 2, email: "hello@example.com", password_digest: "$2a$10$19RSQjgq9iu75e4F.gCSQefWojqBPHexv45VndYPz3lq7PZYJQkXC">
  u.authenticate("notyopassword")
    => false


1. Build my user registration process (signup form and signup creation)
2. Give posts to users
3. Only let them edit posts they make
  * See 1.c

1.c
A. rake db:create_migration NAME=create_posts
  class CreatePosts < ActiveRecord::Migration
    def change
      create_table :posts do |t|
        t.string :title
        t.text :content
        t.integer :user_id #foreign key
      end
    end
  end
B. Make Post model
  class Post < ActiveRecord::Base
    belongs_to :user
  end
C. Add to User model
  has_many :posts
D. rake db:migrate
E. rake console
F.  u = User.last
    u.posts.to_sql
      => "SELECT \"posts\".* FROM \"posts\" WHERE \"posts\".\"user_id\" = 3"
G. u.posts.build(title: "Kerry's Post Title")
      => #<Post:0x007fe2ea3910c8 id: nil, title: "Kerry's Post Title", content: nil, user_id: 3>
H. p = _
   u.save
   p
      => #<Post:0x007fe2ea3910c8 id: 1, title: "Kerry's Post Title", content: nil, user_id: 3>




1. Validations:
2. Add line to app/models/user.rb
  validates :email, :presence => true
3. rake console
  u = User.new
    => #<User:0x007fc789c42e00 id: nil, email: nil, password_digest: nil>
  u.save
    => false
  u.errors
    => #<ActiveModel::Errors:0x007fc789bd8550
    @base=#<User:0x007fc789c42e00 id: nil, email: nil, password_digest: nil>,
    @details={:email=>[{:error=>:blank}], :password=>[{:error=>:blank}]},
    @messages={:email=>["can't be blank"], :password=>["can't be blank"]}>
  u.errors.full_messages
    => ["Email can't be blank", "Password can't be blank"]
