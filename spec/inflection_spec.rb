require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe Extlib::Inflection do

  describe "#pluralize" do
    it 'should pluralize a word' do
      'car'.plural.should == 'cars'
      Extlib::Inflection.pluralize('car').should == 'cars'
    end    
  end

  describe "#singularize" do
    it 'should singularize cars as car' do
      "cars".singular.should == "car"
      Extlib::Inflection.singularize('cars').should == 'car'
    end

    it "should not singularize 'postgres'" do
      Extlib::Inflection.singularize('postgres').should == 'postgres'
    end

    it "should not singularize 'status'" do
      Extlib::Inflection.singularize('status').should == 'status'
    end    
  end

  describe "#classify" do
    it 'classifies data_mapper as DataMaper' do
      Extlib::Inflection.classify('data_mapper').should == 'DataMapper'
    end
    
    it "singularizes string first: classifies data_mappers as egg_and_hams as EggAndHam" do
      Extlib::Inflection.classify('egg_and_hams').should == 'EggAndHam'
    end
  end

  describe "#camelize" do
    it 'camelizes data_mapper as DataMapper' do
      Extlib::Inflection.camelize('data_mapper').should == 'DataMapper'
    end
    
    it "camelizes merb as Merb" do
      Extlib::Inflection.camelize('merb').should == 'Merb'
    end
    
    it "camelizes data_mapper/resource as DataMapper::Resource" do
      Extlib::Inflection.camelize('data_mapper/resource').should == 'DataMapper::Resource'
    end
    
    it "camelizes data_mapper/associations/one_to_many as DataMapper::Associations::OneToMany" do
      Extlib::Inflection.camelize('data_mapper/associations/one_to_many').should == 'DataMapper::Associations::OneToMany'
    end
  end

  describe "#underscore" do
    it 'underscores DataMapper as data_mapper' do
      Extlib::Inflection.underscore('DataMapper').should == 'data_mapper'
    end
    
    it 'underscores Merb as merb' do
      Extlib::Inflection.underscore('Merb').should == 'merb'
    end
    
    it 'underscores DataMapper::Resource as data_mapper/resource' do
      Extlib::Inflection.underscore('DataMapper::Resource').should == 'data_mapper/resource'
    end
    
    it 'underscores Merb::BootLoader::Rackup as merb/boot_loader/rackup' do
      Extlib::Inflection.underscore('Merb::BootLoader::Rackup').should == 'merb/boot_loader/rackup'
    end
  end

  describe "#humanize" do
    it 'replaces _ with space: humanizes employee_salary as Employee salary' do
      Extlib::Inflection.humanize('employee_salary').should == 'Employee salary'      
    end
    
    it "strips _id endings: humanizes author_id as Author" do
      Extlib::Inflection.humanize('author_id').should == 'Author'
    end
  end

  describe "#demodulize" do
    it 'demodulizes module name: DataMapper::Inflector => Inflector' do
      Extlib::Inflection.demodulize('DataMapper::Inflector').should == 'Inflector'
    end
    
    it 'demodulizes module name: A::B::C::D::E => E' do
      Extlib::Inflection.demodulize('A::B::C::D::E').should == 'E'
    end    
  end

  describe "#tableize" do
    it 'should tableize a name (underscore with last word plural)' do
      Extlib::Inflection.tableize('fancy_category').should == 'fancy_categories'
      Extlib::Inflection.tableize('FancyCategory').should == 'fancy_categories'
    
      Extlib::Inflection.tableize('Fancy::Category').should == 'fancy_categories'
    end    
  end

  describe "#foreign_key" do
    it 'should create a fk name from a class name' do
      Extlib::Inflection.foreign_key('Message').should == 'message_id'
      Extlib::Inflection.foreign_key('Admin::Post').should == 'post_id'
    end    
  end
end
