
#
# Specifying rufus-scheduler
#
# Wed Apr 17 06:00:59 JST 2013
#

require 'spec_helper'


describe Rufus::Scheduler::CronJob do

  before :each do
    @scheduler = Rufus::Scheduler.new
  end
  after :each do
    @scheduler.shutdown
  end

  context 'normal' do

    it 'triggers near the zero second' do

      job = @scheduler.schedule_cron '* * * * *' do; end

      sleep_until_next_minute

      (job.last_time.to_i % 10).should == 0
    end
  end

  #context 'sub-minute' do
  #
  #  it 'triggers near the zero second' do
  #
  #    job = @scheduler.schedule_cron '* * * * * *' do; end
  #
  #    sleep 1.5
  #
  #    p job.last_time
  #    p job.last_time.to_f
  #  end
  #end

  context 'first_at/in' do

    it 'does not trigger before first_at is reached' do

      t = Time.now

      job =
        @scheduler.schedule_cron '* * * * * *', :first_in => '3s' do
          triggered = Time.now
        end

      sleep 1

      #p [ t, t.to_f ]
      #p [ job.last_time, job.last_time.to_f ]
      #p [ job.first_at, job.first_at.to_f ]

      job.first_at.should be_within_1s_of(t + 3)
      job.last_time.should == nil
    end

    it 'triggers for the first time at first_at' do

      first_time = nil
      t = Time.now

      job = @scheduler.schedule_cron '* * * * * *', :first_in => '3s' do
        first_time ||= Time.now
      end
      sleep 4.5

      job.first_at.should be_within_1s_of(t + 3)
      first_time.should be_within_1s_of(job.first_at)
    end
  end

  context 'scheduling the cron itself' do

    # for https://github.com/jmettraux/rufus-scheduler/issues/95
    #
    # schedule_cron takes more than 30 seconds, blocking...
    #
    it 'does not sit scheduling and blocking...' do

      n = Time.now
      first = nil

      job = @scheduler.schedule_cron '*/2 * * * * *' do
        first ||= Time.now
      end

      (Time.now - n).should < 1.0

      loop do
        next unless first
        (first - n).should < 4.0
        break
      end
    end
  end
end

