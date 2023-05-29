# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Match, type: :model do
  it { is_expected.to have_many(:match_teams) }
  it { is_expected.to have_many(:teams).through(:match_teams) }
  it { is_expected.to have_many(:performances) }
end
