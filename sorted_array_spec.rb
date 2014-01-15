require 'rspec'
require './sorted_array.rb'

shared_examples "yield to all elements in sorted array" do |method|
    specify do 
      expect do |b| 
        sorted_array.send(method, &b) 
      end.to yield_successive_args(2,3,4,7,9) 
    end
end

describe SortedArray do
  let(:source) { [2,3,4,7,9] }
  let(:sorted_array) { SortedArray.new source }

  describe "iterators" do
    describe "that don't update the original array" do 
      describe :each do
        context 'when passed a block' do
          it_should_behave_like "yield to all elements in sorted array", :each
        end

        it 'should return the array' do
          sorted_array.each {|el| el }.should eq source
        end
      end

      describe :map do
        it 'the original array should not be changed' do
          original_array = sorted_array.internal_arr
          expect { sorted_array.map {|el| el } }.to_not change { original_array }
        end

        it_should_behave_like "yield to all elements in sorted array", :map

        it 'creates a new array containing the values returned by the block' do
          sorted_array.map {|el| el + 1 }.should ==source
          # pending "fill this spec in with a meaningful example"
        end
      end
    end

    describe "that update the original array" do
      describe :map! do
        it 'the original array should be updated' do
          sorted_array.map! {|el| el + 1}.should == [3,4,5,8,10]
        end

        it_should_behave_like "yield to all elements in sorted array", :map!

        it 'should replace value of each element with the value returned by block' do

          sorted_array.map! {|el| el + 1}.should == [3,4,5,8,10]

          # [(2+i),(3+i),(4+i),(7+i),(9+i)]

          # pending "this is just the same as the example above"
        end
      end
    end
  end

  describe :find do

    it "Should return the value that was found" do
      sorted_array.find(2).should == 2
      sorted_array.find(49).should == nil
      # sorted_array.find{|x| x % 2==0}.should == 2

      # pending "define some examples by looking up http://www.ruby-doc.org/core-2.1.0/Enumerable.html#method-i-find"
    end
  end

  describe :inject do
    # specify do 
    #   expect do |b| 
    #     block_with_two_args = Proc.new {|acc,el| return true}
    #     sorted_array.send(method, &b) 
    #   end.to yield_successive_args([]) 
    # end
    it "does not currently have any examples for it" do
      # sorted_array.inject {|accu, n| n + 1}
      # pending "define some examples by looking up http://www.ruby-doc.org/core-2.1.0/Enumerable.html#method-i-inject"
    end
  end
end
