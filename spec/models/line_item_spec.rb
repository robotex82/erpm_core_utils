require 'spec_helper'

describe LineItem do
  context 'associations' do
    it { should belong_to :tax_rate }
  end

  context 'acts as masterdata' do
    it 'should keep its tax rate even when the associated  tax rate is duped' do
      original_tax_rate = TaxRate.create!(:name => 'VAT', :rate => 0.16, :live_from => 2.days.ago)
      line_item = LineItem.create!(:net_price_cents => 100, :tax_rate => original_tax_rate)
      
      new_tax_rate = original_tax_rate.dup
      new_tax_rate.live_from = 1.day.ago
      new_tax_rate.rate = 0.19
      new_tax_rate.save!
      
      line_item.tax_rate.should eq(original_tax_rate)
    end
  end

  context 'validations' do
    it { should validate_presence_of :tax_rate }
  end
end

