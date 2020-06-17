import urllib.request
import html.parser


class MyHTMLParser(html.parser.HTMLParser):
    sites = set()
    words = {}
    url = ""
    body = False

    def get_sites(self):
        return self.sites

    def get_words(self):
        return self.words

    def set_url(self, adr):
        self.url = adr

    def clear(self):
        self.sites = set()
        self.words = {}

    def handle_starttag(self, tag, attrs):
        if tag == "body":
            self.body = True
        if tag == "a":
            for (atr, val) in attrs:
                if atr == "href":
                    if "http" not in val:
                        val = self.url + val
                    self.sites.add(val)

    def handle_data(self, data):
        if self.body:
            for x in data.split():
                if x in self.words.keys():
                    self.words[x] += 1
                else:
                    self.words[x] = 1

    def handle_endtag(self, tag):
        if tag == "body":
            self.body = False


class MyIndex:
    words = {}
    sites = {}

    def get_site(self, adr):
        res = ""
        try:
            res = str(urllib.request.urlopen(adr).read(), encoding="utf-8")
        except:
            pass
        return res

    def index(self, adr, i):
        parser = MyHTMLParser()
        addresses = [adr]
        depth = i + 1
        while addresses and depth:
            elem = addresses.pop(0)
            parser.clear()
            parser.set_url(elem)
            parser.feed(self.get_site(elem))
            self.sites[elem] = parser.get_words()
            for word in self.sites[elem]:
                if word in self.words.keys():
                    self.words[word].append(elem)
                else:
                    self.words[word] = [elem]
            if not addresses:
                addresses += parser.get_sites()
                depth -= 1

    def __getitem__(self, key):
        if key in self.words.keys():
            res = [(s, self.sites[s][key]) for s in self.words[key]]
            return sorted(res, key=lambda x: x[1], reverse=True)
        else:
            return []

    def search(self, word):
        if word in self.words.keys():
            print(word + ":")
            res = [(s, self.sites[s][word]) for s in self.words[word]]
            for e in sorted(res, key=lambda x: x[1], reverse=True):
                print("site: " + e[0] + " number of occurrences:", e[1])
        else:
            print(word, "- not found")


test = MyIndex()
url = "http://www.ii.uni.wroc.pl/~marcinm/"
test.index(url, 1)
test.search("Python")
print()
print(test["wykładzie"])
