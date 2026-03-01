import colorsys
import cv2

def hsv(p):
    r_normalized = p[0] / 255.0
    g_normalized = p[1] / 255.0
    b_normalized = p[2] / 255.0
    h, s, v = colorsys.rgb_to_hsv(r_normalized, g_normalized, b_normalized)
    return [h, s, v, p[3]]

def b2(v):
    return int((v * 255.0) + 0.5)

def rgb(p):
    r, g, b = colorsys.hsv_to_rgb(p[0], p[1], p[2])
    return [b2(r), b2(g), b2(b), p[3]]

def inv_v(p):
    tmp = hsv(p)
    # tmp[1] = 1.0 - tmp[1]
    # tmp[2] = 1.0 - tmp[2]
    # if tmp[2] > 0: print(tmp[2])
    bn = tmp[2]
    bi = 1.0 - tmp[2]
    wn = p[3] / 255.0
    wi = 1.0 - wn
    b = (bn * wn) + (bi * wi)
    return rgb([tmp[0], tmp[1], b, tmp[3]])

img = cv2.imread('./logo.nix.dark.png', cv2.IMREAD_UNCHANGED)
(h, w, _) = img.shape
for x in range(w):
    for y in range(h):
        print([x, y], [w, h])
        img[y, x] = inv_v(img[y, x])

cv2.imwrite("./logo.nix.light.png", img)
