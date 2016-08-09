class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :store
  mount_uploader :attachment, AvatarUploader

  acts_as_votable
  acts_as_commentable

  include PublicActivity::Model
  tracked only: [:create], owner: Proc.new{ |controller, model| controller.current_user }

  validates_presence_of :content
  validates_presence_of :user
  #validates_presence_of :store

end
