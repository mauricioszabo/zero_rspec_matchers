module ActiveRecordStubs
  def stub_valid_record(id=1)
    record = new
    stub!(:new).and_return(record)
    stub!(:create).and_return(record)
    stub!(:create!).and_return(record)
    #stub!(:find).with(id).and_return(record)
    stub!(:find).and_return(record)
    record.stub!(:valid?).and_return(true)
    record.stub!(:update_attributes).and_return(true)
    record.id = id

    def record.save
      stub!(:new_record?).and_return(false)
      return true
    end

    return record
  end

  def stub_existing_valid_record
    record = new
    stub!(:find).and_return(record)
    record.stub!(:valid?).and_return(true)
    record.stub!(:save).and_return(true)
    record.stub!(:update_attributes).and_return(true)
    record.id = id
    record.stub!(:new_record?).and_return(false)

    return record
  end
end

ActiveRecord::Base.send(:extend, ActiveRecordStubs)
