require 'spec_helper'

describe TaxRate do
  context 'A new record' do
    it 'should not have any previous versions' do
      tax_rate = TaxRate.new
      tax_rate.versions.should eq([])
    end
    
    it 'should have a default live_to date with the value 9999-12-31' do
      tax_rate = TaxRate.new
      tax_rate.live_to.should eq(DateTime.new(9999, 12, 31))
    end
  end

  context 'A duped record' do
    it 'should know its previous version' do
      tax_rate = TaxRate.create(:name => 'VAT', :rate => 0.19, :live_from => Time.zone.now)
      updated_tax_rate = tax_rate.dup
      updated_tax_rate.parent.should eq(tax_rate)
    end

    it 'should know its original version' do
      tax_rate = TaxRate.create(:name => 'VAT', :rate => 0.19, :live_from => Time.zone.now)
      updated_tax_rate = tax_rate.dup
      updated_tax_rate.root.should eq(tax_rate)
    end
    
    it 'should set its parent live_to date to its live_from date before save' do
      tax_rate = TaxRate.create(:name => 'VAT', :rate => 0.19, :live_from => 5.minutes.ago)
      
      updated_tax_rate = tax_rate.dup
      updated_tax_rate.live_from = 5.minutes.from_now
      updated_tax_rate.save!
    
      updated_tax_rate.parent.live_to.should eq(updated_tax_rate.live_from)
    end
  end

  context 'chaining' do
    it "should be possible" do
      tax_rate = TaxRate.create(:name => 'VAT', :rate => 0.19, :live_from => Time.zone.now)
      second_tax_rate = tax_rate.dup
      # second_tax_rate.rate = 0.20
      second_tax_rate.live_from = Time.zone.now
      second_tax_rate.save
      third_tax_rate = second_tax_rate.dup
      # third_tax_rate.rate = 0.21
      third_tax_rate.live_from = Time.zone.now
      third_tax_rate.save
      fourth_tax_rate = third_tax_rate.dup
      # fourth_tax_rate.rate = 0.22
      fourth_tax_rate.live_from = Time.zone.now
      fourth_tax_rate.save

      fourth_tax_rate.root.should eq(tax_rate)
    end
    
    it 'children should not be valid without live_from date' do
      tax_rate = TaxRate.create(:name => 'VAT', :rate => 0.19, :live_from => Time.zone.now)
      second_tax_rate = tax_rate.dup
      second_tax_rate.live_from = nil
      second_tax_rate.should_not be_valid
    end
    
    it "children should not accept a valid from date before its parent valid from date" do
      tax_rate = TaxRate.create(:name => 'VAT', :rate => 0.19, :live_from => 5.minutes.ago)
      second_tax_rate = tax_rate.dup
      second_tax_rate.live_from = 10.minutes.ago
      second_tax_rate.should_not be_valid
    end
    
    it 'should not be possible on records that already have a child element' do
      tax_rate = TaxRate.create(:name => 'VAT', :rate => 0.19, :live_from => 10.minutes.ago)
      second_tax_rate = tax_rate.dup
      second_tax_rate.live_from = 5.minutes.ago
      second_tax_rate.save
      
      expect { tax_rate.dup }.to raise_error(ERPM::CoreUtils::ActsAsMasterdata::DupNotAllowedOnParentRecord)
    end
  end

  context 'scopes' do
    context '#live' do
      it 'should only return items that are valid right now' do
        past_tax_rate = TaxRate.create(:name => 'VAT', :rate => 0.18, :live_from => 10.minutes.ago)
        
        valid_tax_rate = past_tax_rate.dup
        valid_tax_rate.live_from = 5.minutes.ago
        valid_tax_rate.rate = 0.19
        valid_tax_rate.save!

        future_tax_rate = valid_tax_rate.dup
        future_tax_rate.live_from = 5.minutes.from_now
        future_tax_rate.rate = 0.20
        future_tax_rate.save!

        TaxRate.live.all.should eq([valid_tax_rate])
      end
    end

    context '#live_at' do
      it 'should only return items that are valid at the given point in time' do
        past_tax_rate = TaxRate.create(:name => 'VAT', :rate => 0.18, :live_from => 10.minutes.ago)
        
        valid_tax_rate = past_tax_rate.dup
        valid_tax_rate.live_from = 5.minutes.ago
        valid_tax_rate.rate = 0.19
        valid_tax_rate.save!

        future_tax_rate = valid_tax_rate.dup
        future_tax_rate.live_from = 5.minutes.from_now
        future_tax_rate.rate = 0.20
        future_tax_rate.save!

        TaxRate.live_at(Time.zone.now).all.should eq([valid_tax_rate])
      end
    end
  end

  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :rate }
  end
end
