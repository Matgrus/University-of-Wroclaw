from PIL import Image
import numpy
import random


def good_add(col, val):
    if col + val > 255:
        return 255
    elif col + val < 0:
        return 0
    else:
        return col + val


def is_grey(pix):

    def diff(x, y, eps):
        if abs(x - y) < eps:
            return True
        else:
            return False

    epsilon = 30
    r, g, b = pix
    return (diff(r, g, epsilon) and diff(r, b, epsilon) and diff(g, b, epsilon) and r + g + b > 100) or \
           (r > 200 and g > 200 and b > 200)


def make_sad(img, name):

    w, h = img.size
    res = Image.new("RGB", (w, h))

    for x in range(w):
        for y in range(h):

            r = img.getpixel((x, y))[0]
            g = img.getpixel((x, y))[1]
            b = img.getpixel((x, y))[2]

            alf = 0.3

            res_col = int((r + g + b) / 3)
            r = alf * r + (1 - alf) * res_col
            g = alf * g + (1 - alf) * res_col
            b = alf * b + (1 - alf) * res_col
            res.putpixel((x, y), (int(r), int(g), int(b)))

    res.save(name)
    return res


def make_happy_v2(img, name):
    w, h = img.size
    res = img.copy()

    def check_neigh(img, pix_pos):
        col_change = 10

        img_w, img_h = img.size
        chck_pos = [(pix_pos[0]-1, pix_pos[1]+1), (pix_pos[0], pix_pos[1]+1), (pix_pos[0]+1, pix_pos[1]+1),
                    (pix_pos[0]-1, pix_pos[1]), (pix_pos[0]+1, pix_pos[1]),
                    (pix_pos[0]-1, pix_pos[1]-1), (pix_pos[0], pix_pos[1]-1), (pix_pos[0]+1, pix_pos[1]-1)]

        avg1 = 0
        avg2 = 0
        avg3 = 0
        l = 0
        for p in chck_pos:
            if 0 <= p[0] < img_w and 0 <= p[1] < img_h:
                if not (is_grey(img.getpixel(p))):
                    l += 1
                    avg1 += (img.getpixel(p)[0])
                    avg2 += (img.getpixel(p)[1])
                    avg3 += (img.getpixel(p)[2])
        if l > 0:
            if avg1 > avg2 > avg3 and avg1 > avg3:
                return good_add(int(avg1 / l), int(col_change)), good_add(int(avg2 / l), int(col_change / 2)), good_add(int(avg3 / l), int(col_change / 4))
            elif avg1 > avg2 and avg1 > avg3 > avg2:
                return good_add(int(avg1 / l), int(col_change)), good_add(int(avg2 / l), int(col_change / 4)), good_add(int(avg3 / l), int(col_change / 2))
            elif avg2 > avg1 > avg3 and avg2 > avg3:
                return good_add(int(avg1 / l), int(col_change / 2)), good_add(int(avg2 / l), int(col_change)), good_add(int(avg3 / l), int(col_change / 4))
            elif avg2 > avg1 and avg2 > avg3 > avg1:
                return good_add(int(avg1 / l), int(col_change / 4)), good_add(int(avg2 / l), int(col_change)), good_add(int(avg3 / l), int(col_change / 2))
            elif avg3 > avg1 > avg2 and avg3 > avg2:
                return good_add(int(avg1 / l), int(col_change / 2)), good_add(int(avg2 / l), int(col_change / 4)), good_add(int(avg3 / l), int(col_change))
            elif avg3 > avg1 and avg3 > avg2 > avg1:
                return good_add(int(avg1 / l), int(col_change / 4)), good_add(int(avg2 / l), int(col_change / 2)), good_add(int(avg3 / l), int(col_change))
            else:
                chck_pos = list(filter(lambda x: 0 <= x[0] < img_w and 0 <= x[1] < img_h and not (is_grey(img.getpixel(x))), chck_pos))
                return img.getpixel(random.choice(chck_pos))

        else:
            return img.getpixel(pix_pos)

    for y in range(h):
        for x in range(w):
            if is_grey(res.getpixel((x, y))):
                res.putpixel((x, y), check_neigh(res, (x, y)))

    res.save(name)
    return res


def make_happy_v1(img, name):
    w, h = img.size
    res = img.copy()

    def check_neigh(img, pix_pos):
        col_change = 10

        img_w, img_h = img.size
        chck_pos = [(pix_pos[0]-1, pix_pos[1]+1), (pix_pos[0], pix_pos[1]+1), (pix_pos[0]+1, pix_pos[1]+1),
                    (pix_pos[0]-1, pix_pos[1]), (pix_pos[0]+1, pix_pos[1]),
                    (pix_pos[0]-1, pix_pos[1]-1), (pix_pos[0], pix_pos[1]-1), (pix_pos[0]+1, pix_pos[1]-1)]

        avg1 = 0
        avg2 = 0
        avg3 = 0
        l = 0
        for p in chck_pos:
            if 0 <= p[0] < img_w and 0 <= p[1] < img_h:
                if not (is_grey(img.getpixel(p))):
                    l += 1
                    avg1 += (img.getpixel(p)[0])
                    avg2 += (img.getpixel(p)[1])
                    avg3 += (img.getpixel(p)[2])
        if l > 0:
            if avg1 > avg2 and avg1 > avg3:
                return good_add(int(avg1 / l), + col_change), int(avg2 / l), int(avg3 / l)
            elif avg2 > avg3:
                return int(avg1 / l), good_add(int(avg2 / l), + col_change), int(avg3 / l)
            else:
                return int(avg1 / l), int(avg2 / l), good_add(int(avg3 / l), + col_change)
        else:
            return img.getpixel(pix_pos)

    for y in range(h):
        for x in range(w):
            if is_grey(res.getpixel((x, y))):
                res.putpixel((x, y), check_neigh(res, (x, y)))

    res.save(name)
    return res


a = Image.open("bunny.jpg")

#test_sad = make_sad(a, "test_bunny_sad.png")
#test_happy = make_happy_v1(a, "test_bunny_happy.png")
test_happy = make_happy_v2(a, "test_bunny_happy.png")

#Image.fromarray(numpy.hstack((numpy.array(test_sad), numpy.array(a)))).show()
Image.fromarray(numpy.hstack((numpy.array(test_happy), numpy.array(a)))).show()



