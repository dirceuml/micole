
#
# Specifying rufus-scheduler
#
# Sat Mar 21 12:55:27 JST 2009
#

require 'tzinfo'
require 'spec_helper'


describe Rufus::Scheduler::CronLine do

  def cl(cronline_string)
    Rufus::Scheduler::CronLine.new(cronline_string)
  end

  def match(line, time)
    cl(line).matches?(time).should == true
  end
  def no_match(line, time)
    cl(line).matches?(time).should == false
  end
  def to_a(line, array)
    cl(line).to_array.should == array
  end

  describe '.new' do

    it 'interprets cron strings correctly' do

      to_a '* * * * *', [ [0], nil, nil, nil, nil, nil, nil, nil ]
      to_a '10-12 * * * *', [ [0], [10, 11, 12], nil, nil,  nil, nil, nil, nil ]
      to_a '* * * * sun,mon', [ [0], nil, nil, nil, nil, [0, 1], nil, nil ]
      to_a '* * * * mon-wed', [ [0], nil, nil, nil, nil, [1, 2, 3], nil, nil ]
      to_a '* * * * 7', [ [0], nil, nil, nil, nil, [0], nil, nil ]
      to_a '* * * * 0', [ [0], nil, nil, nil, nil, [0], nil, nil ]
      to_a '* * * * 0,1', [ [0], nil, nil, nil, nil, [0,1], nil, nil ]
      to_a '* * * * 7,1', [ [0], nil, nil, nil, nil, [0,1], nil, nil ]
      to_a '* * * * 7,0', [ [0], nil, nil, nil, nil, [0], nil, nil ]
      to_a '* * * * sun,2-4', [ [0], nil, nil, nil, nil, [0, 2, 3, 4], nil, nil ]

      to_a '* * * * sun,mon-tue', [ [0], nil, nil, nil, nil, [0, 1, 2], nil, nil ]

      to_a '* * * * * *', [ nil, nil, nil, nil, nil, nil, nil, nil ]
      to_a '1 * * * * *', [ [1], nil, nil, nil, nil, nil, nil, nil ]
      to_a '7 10-12 * * * *', [ [7], [10, 11, 12], nil, nil, nil, nil, nil, nil ]
      to_a '1-5 * * * * *', [ [1,2,3,4,5], nil, nil, nil, nil, nil, nil, nil ]

      to_a '0 0 1 1 *', [ [0], [0], [0], [1], [1], nil, nil, nil ]

      to_a '0 23-24 * * *', [ [0], [0], [23, 0], nil, nil, nil, nil, nil ]
        #
        # as reported by Aimee Rose in
        # https://github.com/jmettraux/rufus-scheduler/issues/56

      to_a '0 23-2 * * *', [ [0], [0], [23, 0, 1, 2], nil, nil, nil, nil, nil ]
    end

    it 'rejects invalid weekday expressions' do

      lambda { cl '0 17 * * MON_FRI' }.should raise_error
        # underline instead of dash

      lambda { cl '* * * * 9' }.should raise_error
      lambda { cl '* * * * 0-12' }.should raise_error
      lambda { cl '* * * * BLABLA' }.should raise_error
    end

    it 'rejects invalid cronlines' do

      lambda { cl '* nada * * 9' }.should raise_error(ArgumentError)
    end

    it 'interprets cron strings with TZ correctly' do

      to_a('* * * * * EST', [ [0], nil, nil, nil, nil, nil, nil, 'EST' ])
      to_a('* * * * * * EST', [ nil, nil, nil, nil, nil, nil, nil, 'EST' ])

      to_a(
        '* * * * * * America/Chicago',
        [ nil, nil, nil, nil, nil, nil, nil, 'America/Chicago' ])
      to_a(
        '* * * * * * America/New_York',
        [ nil, nil, nil, nil, nil, nil, nil, 'America/New_York' ])

      lambda { cl '* * * * * NotATimeZone' }.should raise_error
      lambda { cl '* * * * * * NotATimeZone' }.should raise_error
    end

    it 'interprets cron strings with / (slashes) correctly' do

      to_a(
        '0 */2 * * *',
        [ [0], [0], (0..11).collect { |e| e * 2 }, nil, nil, nil, nil, nil ])
      to_a(
        '0 7-23/2 * * *',
        [ [0], [0], (7..23).select { |e| e.odd? }, nil, nil, nil, nil, nil ])
      to_a(
        '*/10 * * * *',
        [ [0], [0, 10, 20, 30, 40, 50], nil, nil, nil, nil, nil, nil ])

      # fighting https://github.com/jmettraux/rufus-scheduler/issues/65
      #
      to_a(
        '*/10 * * * * Europe/Berlin',
        [ [0], [ 0, 10, 20, 30, 40, 50], nil, nil, nil, nil, nil, 'Europe/Berlin' ])
    end

    it 'accepts lonely / (slashes) (like <= 2.0.19 did)' do

      # fighting https://github.com/jmettraux/rufus-scheduler/issues/65

      to_a(
        '/10 * * * *',
        [ [0], [ 0, 10, 20, 30, 40, 50], nil, nil, nil, nil, nil, nil ])
    end

    it 'rejects / for days (every other wednesday)' do

      lambda {
        Rufus::Scheduler::CronLine.new('* * * * wed/2')
      }.should raise_error(ArgumentError)
    end

    it 'does not support ranges for monthdays (sun#1-sun#2)' do

      lambda {
        Rufus::Scheduler::CronLine.new('* * * * sun#1-sun#2')
      }.should raise_error(ArgumentError)
    end

    it 'accepts items with initial 0' do

      to_a '09 * * * *', [ [0], [9], nil, nil, nil, nil, nil, nil ]
      to_a '09-12 * * * *', [ [0], [9, 10, 11, 12], nil, nil, nil, nil, nil, nil ]
      to_a '07-08 * * * *', [ [0], [7, 8], nil, nil, nil, nil, nil, nil ]
      to_a '* */08 * * *', [ [0], nil, [0, 8, 16], nil, nil, nil, nil, nil ]
      to_a '* */07 * * *', [ [0], nil, [0, 7, 14, 21], nil, nil, nil, nil, nil ]
      to_a '* 01-09/04 * * *', [ [0], nil, [1, 5, 9], nil, nil, nil, nil, nil ]
      to_a '* * * * 06', [ [0], nil, nil, nil, nil, [6], nil, nil ]
    end

    it 'interprets cron strings with L correctly' do

      to_a '* * L * *', [[0], nil, nil, ['L'], nil, nil, nil, nil ]
      to_a '* * 2-5,L * *', [[0], nil, nil, [2,3,4,5,'L'], nil, nil, nil, nil ]
      to_a '* * */8,L * *', [[0], nil, nil, [1,9,17,25,'L'], nil, nil, nil, nil ]
    end

    it 'does not support ranges for L' do

      lambda { cl '* * 15-L * *'}.should raise_error(ArgumentError)
      lambda { cl '* * L/4 * *'}.should raise_error(ArgumentError)
    end

    it 'does not support multiple Ls' do

      lambda { cl '* * L,L * *'}.should raise_error(ArgumentError)
    end

    it 'raises if L is used for something else than days' do

      lambda { cl '* L * * *'}.should raise_error(ArgumentError)
    end

    it 'raises for out of range input' do

      lambda { cl '60-62 * * * *'}.should raise_error(ArgumentError)
      lambda { cl '62 * * * *'}.should raise_error(ArgumentError)
      lambda { cl '60 * * * *'}.should raise_error(ArgumentError)
      lambda { cl '* 25-26 * * *'}.should raise_error(ArgumentError)
      lambda { cl '* 25 * * *'}.should raise_error(ArgumentError)
        #
        # as reported by Aimee Rose in
        # https://github.com/jmettraux/rufus-scheduler/pull/58
    end
  end

  describe '#next_time' do

    def nt(cronline, now)
      Rufus::Scheduler::CronLine.new(cronline).next_time(now)
    end

    it 'computes the next occurence correctly' do

      now = Time.at(0).getutc # Thu Jan 01 00:00:00 UTC 1970

      nt('* * * * *', now).should == now + 60
      nt('* * * * sun', now).should == now + 259200
      nt('* * * * * *', now).should == now + 1
      nt('* * 13 * fri', now).should == now + 3715200

      nt('10 12 13 12 *', now).should == now + 29938200
        # this one is slow (1 year == 3 seconds)
        #
        # historical note:
        # (comment made in 2006 or 2007, the underlying libs got better and
        # that slowness is gone)

      nt('0 0 * * thu', now).should == now + 604800
      nt('00 0 * * thu', now).should == now + 604800

      nt('0 0 * * *', now).should == now + 24 * 3600
      nt('0 24 * * *', now).should == now + 24 * 3600

      now = local(2008, 12, 31, 23, 59, 59, 0)

      nt('* * * * *', now).should == now + 1
    end

    it 'computes the next occurence correctly in UTC (TZ not specified)' do

      now = utc(1970, 1, 1)

      nt('* * * * *', now).should == utc(1970, 1, 1, 0, 1)
      nt('* * * * sun', now).should == utc(1970, 1, 4)
      nt('* * * * * *', now).should == utc(1970, 1, 1, 0, 0, 1)
      nt('* * 13 * fri', now).should == utc(1970, 2, 13)

      nt('10 12 13 12 *', now).should == utc(1970, 12, 13, 12, 10)
        # this one is slow (1 year == 3 seconds)
      nt('* * 1 6 *', now).should == utc(1970, 6, 1)

      nt('0 0 * * thu', now).should == utc(1970, 1, 8)
    end

    it 'computes the next occurence correctly in local TZ (TZ not specified)' do

      now = local(1970, 1, 1)

      nt('* * * * *', now).should == local(1970, 1, 1, 0, 1)
      nt('* * * * sun', now).should == local(1970, 1, 4)
      nt('* * * * * *', now).should == local(1970, 1, 1, 0, 0, 1)
      nt('* * 13 * fri', now).should == local(1970, 2, 13)

      nt('10 12 13 12 *', now).should == local(1970, 12, 13, 12, 10)
        # this one is slow (1 year == 3 seconds)
      nt('* * 1 6 *', now).should == local(1970, 6, 1)

      nt('0 0 * * thu', now).should == local(1970, 1, 8)
    end

    it 'computes the next occurence correctly in UTC (TZ specified)' do

      zone = 'Europe/Stockholm'
      tz = TZInfo::Timezone.get(zone)
      now = tz.local_to_utc(local(1970, 1, 1))
        # Midnight in zone, UTC

      nt("* * * * * #{zone}", now).should == utc(1969, 12, 31, 23, 1)
      nt("* * * * sun #{zone}", now).should == utc(1970, 1, 3, 23)
      nt("* * * * * * #{zone}", now).should == utc(1969, 12, 31, 23, 0, 1)
      nt("* * 13 * fri #{zone}", now).should == utc(1970, 2, 12, 23)

      nt("10 12 13 12 * #{zone}", now).should == utc(1970, 12, 13, 11, 10)
      nt("* * 1 6 * #{zone}", now).should == utc(1970, 5, 31, 23)

      nt("0 0 * * thu #{zone}", now).should == utc(1970, 1, 7, 23)
    end

    #it 'computes the next occurence correctly in local TZ (TZ specified)' do
    #  zone = 'Europe/Stockholm'
    #  tz = TZInfo::Timezone.get(zone)
    #  now = tz.local_to_utc(utc(1970, 1, 1)).localtime
    #    # Midnight in zone, local time
    #  nt("* * * * * #{zone}", now).should == local(1969, 12, 31, 18, 1)
    #  nt("* * * * sun #{zone}", now).should == local(1970, 1, 3, 18)
    #  nt("* * * * * * #{zone}", now).should == local(1969, 12, 31, 18, 0, 1)
    #  nt("* * 13 * fri #{zone}", now).should == local(1970, 2, 12, 18)
    #  nt("10 12 13 12 * #{zone}", now).should == local(1970, 12, 13, 6, 10)
    #  nt("* * 1 6 * #{zone}", now).should == local(1970, 5, 31, 19)
    #  nt("0 0 * * thu #{zone}", now).should == local(1970, 1, 7, 18)
    #end

    it 'computes the next time correctly when there is a sun#2 involved' do

      nt('* * * * sun#1', local(1970, 1, 1)).should == local(1970, 1, 4)
      nt('* * * * sun#2', local(1970, 1, 1)).should == local(1970, 1, 11)

      nt('* * * * sun#2', local(1970, 1, 12)).should == local(1970, 2, 8)
    end

    it 'computes the next time correctly when there is a sun#2,sun#3 involved' do

      nt('* * * * sun#2,sun#3', local(1970, 1, 1)).should == local(1970, 1, 11)
      nt('* * * * sun#2,sun#3', local(1970, 1, 12)).should == local(1970, 1, 18)
    end

    it 'understands sun#L' do

      nt('* * * * sun#L', local(1970, 1, 1)).should == local(1970, 1, 25)
    end

    it 'understands sun#-1' do

      nt('* * * * sun#-1', local(1970, 1, 1)).should == local(1970, 1, 25)
    end

    it 'understands sun#-2' do

      nt('* * * * sun#-2', local(1970, 1, 1)).should == local(1970, 1, 18)
    end

    it 'computes the next time correctly when "L" (last day of month)' do

      nt('* * L * *', lo(1970, 1, 1)).should == lo(1970, 1, 31)
      nt('* * L * *', lo(1970, 2, 1)).should == lo(1970, 2, 28)
      nt('* * L * *', lo(1972, 2, 1)).should == lo(1972, 2, 29)
      nt('* * L * *', lo(1970, 4, 1)).should == lo(1970, 4, 30)
    end

    it 'returns a time with subseconds chopped off' do

      nt('* * * * *', Time.now).usec.should == 0
      nt('* * * * *', Time.now).iso8601(10).match(/\.0+[^\d]/).should_not == nil
    end
  end

  describe '#previous_time' do

    def pt(cronline, now)
      Rufus::Scheduler::CronLine.new(cronline).previous_time(now)
    end

    it 'returns the previous time the cron should have triggered' do

      pt('* * * * sun', lo(1970, 1, 1)).should == lo(1969, 12, 28, 23, 59, 00)
      pt('* * 13 * *', lo(1970, 1, 1)).should == lo(1969, 12, 13, 23, 59, 00)
      pt('0 12 13 * *', lo(1970, 1, 1)).should == lo(1969, 12, 13, 12, 00)
      pt('0 0 2 1 *', lo(1970, 1, 1)).should == lo(1969, 1, 2, 0, 00)

      pt('* * * * * sun', lo(1970, 1, 1)).should == lo(1969, 12, 28, 23, 59, 59)
    end
  end

  describe '#matches?' do

    it 'matches correctly in UTC (TZ not specified)' do

      match '* * * * *', utc(1970, 1, 1, 0, 1)
      match '* * * * sun', utc(1970, 1, 4)
      match '* * * * * *', utc(1970, 1, 1, 0, 0, 1)
      match '* * 13 * fri', utc(1970, 2, 13)

      match '10 12 13 12 *', utc(1970, 12, 13, 12, 10)
      match '* * 1 6 *', utc(1970, 6, 1)

      match '0 0 * * thu', utc(1970, 1, 8)

      match '0 0 1 1 *', utc(2012, 1, 1)
      no_match '0 0 1 1 *', utc(2012, 1, 1, 1, 0)
    end

    it 'matches correctly in local TZ (TZ not specified)' do

      match '* * * * *', local(1970, 1, 1, 0, 1)
      match '* * * * sun', local(1970, 1, 4)
      match '* * * * * *', local(1970, 1, 1, 0, 0, 1)
      match '* * 13 * fri', local(1970, 2, 13)

      match '10 12 13 12 *', local(1970, 12, 13, 12, 10)
      match '* * 1 6 *', local(1970, 6, 1)

      match '0 0 * * thu', local(1970, 1, 8)

      match '0 0 1 1 *', local(2012, 1, 1)
      no_match '0 0 1 1 *', local(2012, 1, 1, 1, 0)
    end

    it 'matches correctly in UTC (TZ specified)' do

      zone = 'Europe/Stockholm'

      match "* * * * * #{zone}", utc(1969, 12, 31, 23, 1)
      match "* * * * sun #{zone}", utc(1970, 1, 3, 23)
      match "* * * * * * #{zone}", utc(1969, 12, 31, 23, 0, 1)
      match "* * 13 * fri #{zone}", utc(1970, 2, 12, 23)

      match "10 12 13 12 * #{zone}", utc(1970, 12, 13, 11, 10)
      match "* * 1 6 * #{zone}", utc(1970, 5, 31, 23)

      match "0 0 * * thu #{zone}", utc(1970, 1, 7, 23)
    end

    it 'matches correctly when there is a sun#2 involved' do

      match '* * 13 * fri#2', utc(1970, 2, 13)
      no_match '* * 13 * fri#2', utc(1970, 2, 20)
    end

    it 'matches correctly when there is a L involved' do

      match '* * L * *', utc(1970, 1, 31)
      no_match '* * L * *', utc(1970, 1, 30)
    end

    it 'matches correctly when there is a sun#2,sun#3 involved' do

      no_match '* * * * sun#2,sun#3', local(1970, 1, 4)
      match '* * * * sun#2,sun#3', local(1970, 1, 11)
      match '* * * * sun#2,sun#3', local(1970, 1, 18)
      no_match '* * * * sun#2,sun#3', local(1970, 1, 25)
    end

    it 'matches correctly for seconds' do

      match '* * * * * *', local(1970, 1, 11)
      match '* * * * * *', local(1970, 1, 11, 0, 0, 13)
    end

    it 'matches correctly for seconds / interval' do

      match '*/2 * * * * *', local(1970, 1, 11)
      match '*/5 * * * * *', local(1970, 1, 11)
      match '*/5 * * * * *', local(1970, 1, 11, 0, 0, 0)
      no_match '*/5 * * * * *', local(1970, 1, 11, 0, 0, 1)
      match '*/5 * * * * *', local(1970, 1, 11, 0, 0, 5)
      match '*/2 * * * * *', local(1970, 1, 11, 0, 0, 2)
      match '*/2 * * * * *', local(1970, 1, 11, 0, 0, 2, 500)
    end
  end

  describe '#monthdays' do

    it 'returns the appropriate "sun#2"-like string' do

      class Rufus::Scheduler::CronLine
        public :monthdays
      end

      cl = Rufus::Scheduler::CronLine.new('* * * * *')

      cl.monthdays(local(1970, 1, 1)).should == %w[ thu#1 thu#-5 ]
      cl.monthdays(local(1970, 1, 7)).should == %w[ wed#1 wed#-4 ]
      cl.monthdays(local(1970, 1, 14)).should == %w[ wed#2 wed#-3 ]

      cl.monthdays(local(2011, 3, 11)).should == %w[ fri#2 fri#-3 ]
    end
  end

  describe '#frequency' do

    it 'returns the shortest delta between two occurrences' do

      Rufus::Scheduler::CronLine.new(
          '* * * * *').frequency.should == 60
      Rufus::Scheduler::CronLine.new(
          '* * * * * *').frequency.should == 1

      Rufus::Scheduler::CronLine.new(
          '5 23 * * *').frequency.should == 24 * 3600
      Rufus::Scheduler::CronLine.new(
          '5 * * * *').frequency.should == 3600
      Rufus::Scheduler::CronLine.new(
          '10,20,30 * * * *').frequency.should == 600

      Rufus::Scheduler::CronLine.new(
          '10,20,30 * * * * *').frequency.should == 10
    end
  end

  describe '#brute_frequency' do

    it 'returns the shortest delta between two occurrences' do

      Rufus::Scheduler::CronLine.new(
          '* * * * *').brute_frequency.should == 60
      Rufus::Scheduler::CronLine.new(
          '* * * * * *').brute_frequency.should == 1

      Rufus::Scheduler::CronLine.new(
          '5 23 * * *').brute_frequency.should == 24 * 3600
      Rufus::Scheduler::CronLine.new(
          '5 * * * *').brute_frequency.should == 3600
      Rufus::Scheduler::CronLine.new(
          '10,20,30 * * * *').brute_frequency.should == 600

      #Rufus::Scheduler::CronLine.new(
      #    '10,20,30 * * * * *').brute_frequency.should == 10
        #
        # takes > 20s ...
    end
  end

  context 'summer time' do

    # let's assume summer time jumps always occur on sundays

    # cf gh-114
    #
    it 'schedules correctly through a switch into summer time' do

      #j = `zdump -v Europe/Berlin | grep "Sun Mar" | grep 2014`.split("\n")[0]
      #j = j.match(/^.+ (Sun Mar .+ UTC) /)[1]
        # only works on system that have a zdump...

      in_zone 'Europe/Berlin' do

        # find the summer jump

        j = Time.parse('2014-02-28 12:00')
        loop do
          jj = j + 24 * 3600
          break if jj.isdst
          j = jj
        end

        # test

        friday = j - 24 * 3600 # one day before

        # verify the playground...
        #
        friday.isdst.should == false
        (friday + 24 * 3600 * 3).isdst.should == true

        cl0 = Rufus::Scheduler::CronLine.new('02 00 * * 1,2,3,4,5')
        cl1 = Rufus::Scheduler::CronLine.new('45 08 * * 1,2,3,4,5')

        n0 = cl0.next_time(friday)
        n1 = cl1.next_time(friday)

        n0.strftime('%H:%M:%S %^a').should == '00:02:00 MON'
        n1.strftime('%H:%M:%S %^a').should == '08:45:00 MON'

        n0.isdst.should == true
        n1.isdst.should == true

        (n0 - 24 * 3600 * 3).strftime('%H:%M:%S %^a').should == '23:02:00 THU'
        (n1 - 24 * 3600 * 3).strftime('%H:%M:%S %^a').should == '07:45:00 FRI'
      end
    end

    it 'schedules correctly through a switch out of summer time' do

      in_zone 'Europe/Berlin' do

        # find the winter jump

        j = Time.parse('2014-08-31 12:00')
        loop do
          jj = j + 24 * 3600
          break if jj.isdst == false
          j = jj
        end

        # test

        friday = j - 24 * 3600 # one day before

        # verify the playground...
        #
        friday.isdst.should == true
        (friday + 24 * 3600 * 3).isdst.should == false

        cl0 = Rufus::Scheduler::CronLine.new('02 00 * * 1,2,3,4,5')
        cl1 = Rufus::Scheduler::CronLine.new('45 08 * * 1,2,3,4,5')

        n0 = cl0.next_time(friday)
        n1 = cl1.next_time(friday)

        n0.strftime('%H:%M:%S %^a').should == '00:02:00 MON'
        n1.strftime('%H:%M:%S %^a').should == '08:45:00 MON'

        n0.isdst.should == false
        n1.isdst.should == false

        (n0 - 24 * 3600 * 3).strftime('%H:%M:%S %^a').should == '01:02:00 FRI'
        (n1 - 24 * 3600 * 3).strftime('%H:%M:%S %^a').should == '09:45:00 FRI'
      end
    end
  end
end

