require 'spec_helper'

describe Restaurant do
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:code) }
  it { should allow_mass_assignment_of(:description) }
  it { should allow_mass_assignment_of(:phone) }
  it { should allow_mass_assignment_of(:address) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:address) }

  it { should validate_uniqueness_of(:code) }
end
