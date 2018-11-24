from bs4 import BeautifulSoup
import bs4
import requests
import csv

def getApartmentsDotComHtml(url):
    headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'}
    response = requests.get(url, headers=headers)
    html = response.content.decode('utf-8')
    return BeautifulSoup(html, 'lxml')

def getDistance(street, city, state, zipcode):
    # TODO: either use google maps API or hardcode for apartments of our choice. later
    return 0.0
    
def getPropertyNameAndAddress(soup):
    propertyName = soup.find('h1', attrs={'class':'propertyName'}).text.strip()
    addressComplete = soup.find('div', attrs={'class':'propertyAddress'}).h2.children
    _, street, _, city, _, state, _, zipcode, _ = (c.text if isinstance(c, bs4.element.Tag) else c for c in addressComplete)
    address = ', '.join([street, city, state, zipcode])
    distance = getDistance(street, city, state, zipcode)
    return {'propertyname' : propertyName, 'address' : address, 'city' : city, 'distance' : distance}

def parseAvailabilityRow(trSoup, baseRow):
    row = dict(baseRow)
    for td in trSoup.children:
        if not isinstance(td, bs4.element.Tag):
            continue
        if td.name != 'td':
            continue
        
        if td['class'][0] == 'beds' or td['class'][0] == 'baths':
            v = td.find('span').text.strip().split(' ')[0]
            row[td['class'][0]] = '1.5' if v == '1½' else v
        elif td['class'][0] in ['rent', 'deposit', 'sqft']:
            minmaxV = td.text.strip().replace('$', '').replace(' Sq Ft', '').replace(',', '')
            minmaxV = minmaxV.split('-')
            if len(minmaxV) == 1:
                minV = minmaxV[0].strip()
                maxV = minmaxV[0].strip()
            else:
                minV = minmaxV[0].strip()
                maxV = minmaxV[1].strip()
            row['min' + td['class'][0]] = minV
            row['max' + td['class'][0]] = maxV
    return row
        
def parseAvailabilityTable(soup, baseRow):
    availabilitytable = soup.find('table', attrs={'class':'availabilityTable'}).tbody
    availability = []
    for tr in availabilitytable.children:
        if not isinstance(tr, bs4.element.Tag):
            continue
        if tr.name != 'tr':
            continue
        availability.append(parseAvailabilityRow(tr, baseRow))
    return availability

def parseUrl(url):    
    htmlSoup = getApartmentsDotComHtml(url)
    baseRow = getPropertyNameAndAddress(htmlSoup)
    baseRow['url'] = url
    return parseAvailabilityTable(htmlSoup, baseRow)   

def main():
    with open('apartmentsdotcomurls.txt') as f, open('apartmentsdotcom.csv', 'w') as c:
        columns = ['propertyname', 'address', 'city', 'beds', 'baths', 'minrent', 'maxrent', 'mindeposit', 'maxdeposit', 'minsqft', 'maxsqft', 'distance', 'url']
        csvwriter = csv.DictWriter(c, fieldnames=columns)
        csvwriter.writeheader()
        for url in f:
            url = url.strip()
            # Lines starting with # are comments
            if url.strip().startswith('#') or len(url.strip()) == 0:
                continue
            print("Processing url: ", url)
            dict_data = parseUrl(url)
            for data in dict_data:
                csvwriter.writerow(data)


main()

