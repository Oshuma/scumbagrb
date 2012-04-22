module Scumbag
  module Commands
    # TODO: Allow FQDN to be passed as well.
    class GeoIP < Scumbag::Commands::BaseCommand
      include Cinch::Plugin

      # Command pattern: <prefix>geo
      match /geo/

      # Command name and options.
      set :plugin_name, 'geo'
      set :prefix, '?'
      set :help, "Usage: #{self.prefix}#{self.plugin_name} <ip>"

      # Geolocate the given IP.
      def execute(m)
        ip = extract_args(m)
        m.reply(geo_ip(ip))
      end

      private

      def geo_ip(ip)
        # Ensure that +ip+ is valid.
        begin
          IPAddr.new(ip)
        rescue
          return "'#{ip}' is not a valid IP."
        end

        loc = ::Geokit::Geocoders::MultiGeocoder.geocode(ip)

        "#{ip}: #{loc.city}, #{loc.state}, #{loc.country_code} | #{loc.lat}, #{loc.lng}"
      end
    end
  end
end
