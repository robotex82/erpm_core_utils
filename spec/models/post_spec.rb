require 'spec_helper'

describe Post do
  context 'acts as worm' do
    it 'should not allow changes to the title' do
      post = Post.new
      post.title = 'foo'
      post.save!

      post.title = 'bar'
      post.should_not be_valid
    end

    it 'should allow changes to the body' do
      post = Post.new(:title => 'title')
      post.body = 'foo'
      post.save!

      post.body = 'bar'
      post.should be_valid
    end

    it 'should not allow destroy' do
      post = Post.create(:title => 'foo', :body => 'bar')
      expect { post.destroy }.to raise_error(ActiveRecord::ReadOnlyRecord)  
    end
    
    it 'should not allow destroy all' do
      post = Post.create(:title => 'foo', :body => 'bar')
      expect { Post.destroy_all }.to raise_error(ActiveRecord::ReadOnlyRecord)  
    end

    it 'should not allow delete' do
      post = Post.create(:title => 'foo', :body => 'bar')
      expect { post.delete }.to raise_error(ActiveRecord::ReadOnlyRecord)  
    end
    
    it 'should not allow delete all' do
      post = Post.create(:title => 'foo', :body => 'bar')
      expect { Post.delete_all }.to raise_error(ActiveRecord::ReadOnlyRecord)  
    end
  end

  context 'validations' do
    it { should validate_presence_of :title }
  end
end

