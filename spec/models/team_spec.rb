# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team, type: :model do
  it { is_expected.to have_many(:players) }
  it { is_expected.to have_many(:matches) }
end