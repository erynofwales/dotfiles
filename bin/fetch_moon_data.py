#!/usr/bin/env python3
# Eryn Wells <eryn@erynwells.me>

'''
Fetch moon data from api.met.no.
'''

import argparse
import datetime
import json
import os.path
import requests
import sys
import pytz

API_URL = 'https://api.met.no/weatherapi/sunrise/2.0/.json'

# From https://en.wikipedia.org/wiki/San_Francisco
SAN_FRANCISCO_LAT_LON = (37.7775, -122.416389)
SAN_FRANCISCO_TIMEZONE = 'America/Los_Angeles'

def parse_args(argv, *a, **kw):
    parser = argparse.ArgumentParser(*a, **kw)
    parser.add_argument('--date',
        help='''
            Starting date for number of days to fetch in YYYY-MM-DD format.
            Defaults to today's date.
        ''')
    parser.add_argument('--days', type=int, default=1,
        help='''
            Number of days of data to fetch. The max is 15 per API rules. See
            https://api.met.no/weatherapi/sunrise/2.0/documentation#Output_format
            for details.
        ''')
    parser.add_argument('-l', '--location',
        default='{0[0]},{0[1]}'.format(SAN_FRANCISCO_LAT_LON),
        help='''
            Geolocation in latitude and longitude coordinates separated by a
            comma. If this argument is omitted, the geolocation of San
            Francisco, CA, USA will be used instead.
        ''')
    parser.add_argument('-n', '--dry-run', action='store_true',
        help="Do everything but write downloaded data to the file.")
    parser.add_argument('-t', '--timezone', default=SAN_FRANCISCO_TIMEZONE,
        help='''
            Timezone to query for. If this argument is omitted,
            'America/Los_Angeles' will be used.
        ''')
    parser.add_argument('file')
    args = parser.parse_args(argv)
    return args

def offset_to_timedelta(offset):
    hours, minutes = offset.split(':')
    return datetime.timedelta(hours=hours, minutes=minutes)

def lat_long_from_location(location):
    try:
        lat_lon = tuple(round(float(x), 1) for x in location.split(','))
    except ValueError:
        print("Unable to parse '{location}' into a lat/lon pair.")
        return None, None

    if len(lat_lon) != 2:
        print("Unable to parse '{location}' into a lat/lon pair.")
        return None, None

    return lat_lon[0], lat_lon[1]

def download_moon_data(latitude, longitude, date, utc_offset, number_of_days, dry_run):
    print(f"Downloading {number_of_days} {'days' if number_of_days != 1 else 'day'} of moon data starting {date} {utc_offset}.", file=sys.stderr)

    moon_data = {
        'location': {}
    }

    for _ in range(number_of_days):
        if not dry_run:
            print(f"Fetching data for {date}.", file=sys.stderr)
            response = requests.get(API_URL, params={
                'lat': latitude,
                'lon': longitude,
                'date': date.strftime('%Y-%m-%d'),
                'offset': utc_offset,
                'days': 1,
            })

            try:
                response_json = response.json()
            except json.JSONDecodeError as e:
                print(f'Error decoding JSON response: {e}', file=sys.stderr)
                print(response.text, file=sys.stderr)
                raise

            moon_data.setdefault('meta', response_json['meta'])
            moon_data['location'].setdefault('height', response_json['location']['height'])
            moon_data['location'].setdefault('latitude', response_json['location']['latitude'])
            moon_data['location'].setdefault('longitude', response_json['location']['longitude'])
            moon_data['location'].setdefault('time', [])
            moon_data['location']['time'].append(response_json['location']['time'][0])
        else:
            print(f"Dry run. Fetching data for {date} will be skipped.", file=sys.stderr)

        date = date + datetime.timedelta(days=1)

    return moon_data

def main(argv):
    args = parse_args(argv[1:], prog=argv[0])

    timezone = pytz.timezone(args.timezone)

    date = None
    try:
        date = datetime.datetime.strptime(args.date, '%Y-%m-%d')
    except ValueError:
        date = datetime.datetime.now(tz=timezone).date()
        print("Date must be in YYYY-MM-DD format.", file=sys.stderr)
    except TypeError:
        date = datetime.datetime.now(tz=timezone).date()
        print("No date was given.", file=sys.stderr)

    print(f"Using date: {date}.", file=sys.stderr)

    # Check args.file for some moon data that has already been downloaded.
    moon_data = None
    filename = args.file
    if os.path.isfile(filename):
        try:
            with open(filename, 'r') as f:
                moon_data = json.load(f)
        except json.JSONDecodeError:
            print(f"{filename} contains invalid JSON data.", file=sys.stderr)
            moon_data = None

    if args.location:
        lat, lon = lat_long_from_location(args.location)
    else:
        print("No location given.", file=sys.stderr)
        lat, lon = None, None

    utc_offset = datetime.datetime.now(tz=pytz.timezone(args.timezone)).strftime('%z')
    utc_offset = utc_offset[:3] + ':' + utc_offset[3:]

    if moon_data:
        should_fetch_new_data = False

        moon_data_location = moon_data['location']
        try:
            moon_data_lat, moon_data_lon = (
                float(moon_data_location['latitude']),
                float(moon_data_location['longitude'])
            )
        except KeyError:
            print(f'{filename} is missing lat,lon information.')
            should_fetch_new_data = True

        if not should_fetch_new_data and (moon_data_lat != lat or moon_data_lon != lon):
            print(f"Data for {lat},{lon} requested, but {filename} has data for {moon_data_lat},{moon_data_lon}.", file=sys.stderr)
            should_fetch_new_data = True

        if not should_fetch_new_data:
            for record in moon_data_location['time']:
                try:
                    record_date = datetime.datetime.strptime(record['date'], '%Y-%m-%d').date()
                except (ValueError, TypeError):
                    continue

                if record_date == date and record.get('moonphase'):
                    print(f"{filename} has existing moon phase data for {date}.", file=sys.stderr)
                    #break
            else:
                should_fetch_new_data = True

        if should_fetch_new_data:
            print(f"{filename} doesn't contain moon data for the given date.",
                    file=sys.stderr)

            if not lat or not lon:
                print(f"No location given. Using {moon_data_lat},{moon_data_lon} from {filename}.", file=sys.stderr)
                lat = moon_data_lat
                lon = moon_data_lon

            try:
                moon_data = download_moon_data(lat, lon, date, utc_offset, args.days, args.dry_run)
                if not args.dry_run:
                    with open(filename, 'w') as f:
                        json.dump(moon_data, f, indent=2)
                else:
                    print(f"Dry run. Dumping moon data to {filename} will be skipped.")
            except json.JSONDecodeError:
                return -1

    if not moon_data:
        print(f"{filename} doesn't contain any moon data.", file=sys.stderr)
        try:
            moon_data = download_moon_data(lat, lon, date, utc_offset, args.days, args.dry_run)
            with open(filename, 'w') as f:
                json.dump(moon_data, f, indent=2)
        except json.JSONDecodeError:
            return -1

    return 0

if __name__ == '__main__':
    import sys
    result = main(sys.argv)
    sys.exit(0 if not result else result)
