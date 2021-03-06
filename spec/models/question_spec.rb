require 'rails_helper'
require Rails.root.join 'spec/models/concerns/votable_spec.rb'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many :attachments }
  
  it_behaves_like 'votable'
  
  it { should belong_to :user }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  
  it { accept_nested_attributes_for :attachments }
end
