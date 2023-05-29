# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Performance, type: :model do
  it { is_expected.to belong_to(:players) }
  it { is_expected.to belong_to(:matches) }
end