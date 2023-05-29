# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Match, type: :model do
  it { is_expected.to belong_to(:team) }
  it { is_expected.to have_many(:performances) }
end