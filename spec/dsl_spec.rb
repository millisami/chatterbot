require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Chatterbot::DSL" do
  describe "client routines" do
    before(:each) do
      @bot = mock(Chatterbot::Bot)
      @bot.send :require, 'chatterbot/dsl'

      Chatterbot::DSL.stub!(:bot).and_return(@bot)
    end
    
    describe "blacklist" do
      it "#blacklist passes along to bot object" do
        @bot.should_receive(:blacklist=).with(["foo"])
        blacklist ["foo"]
      end

      it "#blacklist turns single-string arg into an array" do
        @bot.should_receive(:blacklist=).with(["foo"])
        blacklist "foo"
      end

      it "#blacklist turns comma-delimited string arg into an array" do
        @bot.should_receive(:blacklist=).with(["foo", "bar"])
        blacklist "foo, bar"
      end
    end

    [:no_update, :debug_mode, :verbose].each do |method|
      describe method.to_s do
        it "#{method.to_s} with nil passes along true to bot object" do
          @bot.should_receive("#{method.to_s}=").with(true)
          send method
        end

        it "#debug_mode with false is passed" do
          @bot.should_receive("#{method.to_s}=").with(false)
          send method, false
        end

        it "#debug_mode with true is passed" do
          @bot.should_receive("#{method.to_s}=").with(true)          
          send method, true
        end
      end
    end
    
    describe "exclude" do
      it "#exclude passes along to bot object" do
        @bot.should_receive(:exclude=).with(["foo"])
        exclude ["foo"]
      end

      it "#exclude turns single-string arg into an array" do
        @bot.should_receive(:exclude=).with(["foo"])
        exclude "foo"
      end

      it "#exclude turns comma-delimited string arg into an array" do
        @bot.should_receive(:exclude=).with(["foo", "bar"])
        exclude "foo, bar"
      end
    end
    
    
    it "#search passes along to bot object" do
      @bot.should_receive(:search).with("foo", { })
      search("foo")
    end

    it "#search passes along to bot object" do
      @bot.should_receive(:search).with(["foo","bar"], { })
      search(["foo","bar"])
    end
    
    it "#replies passes along to bot object" do
      @bot.should_receive(:replies)
      replies
    end

    it "#tweet passes along to bot object" do
      @bot.should_receive(:tweet).with("hello sailor!", {:foo => "bar" }, nil)
      tweet "hello sailor!", {:foo => "bar"}
    end

    it "#reply passes along to bot object" do
      @bot.should_receive(:reply).with("hello sailor!", { :source => "source "})
      reply "hello sailor!", { :source => "source "}
    end    

    describe "update_config" do
      it "should pass to bot object" do
        @bot.should_receive(:update_config)
        update_config
      end
    end

    describe "since_id" do
      it "should pass to bot object" do
        @bot.should_receive(:config).and_return({:since_id => 1234})
        since_id.should == 1234
      end
    end

  end
end
