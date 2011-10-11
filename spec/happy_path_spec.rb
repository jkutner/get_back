require '../lib/get_back'

class Foo
  extend GetBack::JoJo

  attr_accessor :step1, :step2, :step3

  def initialize
    @step1 = false
    @step2 = false
    @step3 = false
  end

  def do_it
    sleep(1) until @step1 == true
    @step2 = true
  end
  get_back :do_it

  def do_it_fixed
    sleep(1) until @step1 == true
    @step2 = true
  end
  get_back :do_it_fixed, :pool => 2

  def do_it_success
    sleep(1) until @step1 == true
    @step2 = true
  end
  get_back :do_it_success do |f|
    f.step3 = true
  end

  def do_it_rescue
    sleep(1) until @step1 == true
    @step2 = true
    raise "Some Error"
  end
  get_back :do_it_rescue, :rescue => :callback1

  def callback1(e)
    @step3 = true
  end

  def do_it_ensure
    sleep(1) until @step1 == true
    @step2 = true
    raise "Some Error"
  end
  get_back :do_it_ensure, :ensure => :callback0

  def callback0
    @step3 = true
  end

  def do_it_args(a, b, c)
    sleep(1) until @step1 == true
    @step2 = a && b && c
  end
  get_back :do_it_args
end

describe Foo do

  context "#do_it" do
    it "runs in the background" do
      subject.do_it
      sleep(2)
      subject.step1.should be_false
      subject.step2.should be_false
      subject.step1 = true
      sleep(1)
      subject.step2.should be_true
      subject.step1.should be_true
    end
  end

  context "#do_it_args" do
    it "runs in the background" do
      subject.do_it_args(true, true, true)
      sleep(2)
      subject.step1.should be_false
      subject.step2.should be_false
      subject.step1 = true
      sleep(1)
      subject.step2.should be_true
      subject.step1.should be_true
    end
  end

  context "#do_it_fixed" do
    it "runs in the background" do
      subject.do_it_fixed
      sleep(2)
      subject.step1.should be_false
      subject.step2.should be_false
      subject.step1 = true
      sleep(1)
      subject.step2.should be_true
      subject.step1.should be_true
    end
  end

  context "#do_it_success" do
    it "runs in the background" do
      subject.do_it_success
      sleep(2)
      subject.step1.should be_false
      subject.step2.should be_false
      subject.step3.should be_false
      subject.step1 = true
      sleep(1)
      subject.step2.should be_true
      subject.step1.should be_true
      subject.step3.should be_true
    end
  end

  context "#do_it_rescue" do
    it "runs in the background" do
      subject.do_it_rescue
      sleep(2)
      subject.step1.should be_false
      subject.step2.should be_false
      subject.step3.should be_false
      subject.step1 = true
      sleep(1)
      subject.step2.should be_true
      subject.step1.should be_true
      subject.step3.should be_true
    end
  end

  context "#do_it_ensure" do
    it "runs in the background" do
      subject.do_it_ensure
      sleep(2)
      subject.step1.should be_false
      subject.step2.should be_false
      subject.step3.should be_false
      subject.step1 = true
      sleep(1)
      subject.step2.should be_true
      subject.step1.should be_true
      subject.step3.should be_true
    end
  end
end

