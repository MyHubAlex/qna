require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it { should belong_to(:attachable) }
  
  #it { should validate_presence_of :file }
  #it { should validate_presence_of :attachable_id }
  #it { should validate_presence_of :attachable_type }
end
