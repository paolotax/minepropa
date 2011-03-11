# == Schema Information
# Schema version: 20110311150026
#
# Table name: feed_entries
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  summary      :text
#  url          :string(255)
#  published_at :datetime
#  guid         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class FeedEntry < ActiveRecord::Base
  
  def self.update_from_feed(feed_url)
      feed = Feedzirra::Feed.fetch_and_parse(feed_url)
      add_entries(feed.entries)
    end

    def self.update_from_feed_continuously(feed_url, delay_interval = 15.minutes)
      feed = Feedzirra::Feed.fetch_and_parse(feed_url)
      add_entries(feed.entries)
      loop do
        sleep delay_interval
        feed = Feedzirra::Feed.update(feed)
        add_entries(feed.new_entries) if feed.updated?
      end
    end

    private

    def self.add_entries(entries)
      entries.each do |entry|
        unless exists? :guid => entry.id
          create!(
            :name         => entry.title,
            :summary      => entry.summary,
            :url          => entry.url,
            :published_at => entry.published,
            :guid         => entry.id
          )
        end
      end
    end
end
