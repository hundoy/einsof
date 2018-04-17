#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from PIL import Image
from psd_tools import PSDImage
import math
import os
import sys

TW = 1280
TH = 720
OUTPUT_DIR = "lh_output"

if __name__=='__main__':
    print("start lh psd process")
    #psdFile = "D:/wwd/GameMakerStudio2/asserts/yht_normal.psd"
    # psdFile = "D:/wwd/GameMakerStudio2/asserts/java_normal.psd"
    # psdFile = "D:/wwd/GameMakerStudio2/asserts/java_think.psd"
    psdFile = "D:/wwd/GameMakerStudio2/asserts/red_normal.psd"
    # psdFile = sys.argv[1]

    psd = PSDImage.load(psdFile)

    # params
    h = psd.height
    w = psd.width
    face_bbox = None

    psd.print_tree()

    print("-------")

    for lay in psd.layers:
        lay_n = lay.name

        if lay_n.find("lh_")>-1:
            # name decided
            arr = lay_n.split("_")

            lh_n = arr[1]
            lh_gid = arr[2]
            lh_gname = arr[3]

            # prepare output dir
            if not os.path.exists(OUTPUT_DIR):
                os.makedirs(OUTPUT_DIR)

            # this is a lh group.
            face_group = None
            for sub_lay in lay.layers:
                n = sub_lay.name
                t = sub_lay.kind
                print("%s %s" % (n, t))

                if n=="face" and t=="group":
                    # face group
                    face_group = sub_lay
                elif n=="face_rect" and t=="pixel":
                    # face rect
                    face_bbox = sub_lay.bbox
                elif t=="pixel" and n.find("c_")>-1:
                    # c_ body layers
                    img = sub_lay.as_PIL()

                    img_box = sub_lay.bbox
                    save_img = Image.new('RGBA', (TW/2, TH), (255, 255, 255,0))
                    reg = img.crop((0,0,img_box.width,h-img_box.y1))
                    #reg.save(sub_lay.name + "_reg.png")

                    actual_w = int(math.floor(img_box.width*TW/w))
                    actual_h = int(math.floor((h-img_box.y1)*1.0*TH/h))
                    reg = reg.resize((actual_w,actual_h), Image.ANTIALIAS)

                    # check lh left or right
                    actual_ox = 0
                    if (img_box.x1>w/2):
                        # right
                        actual_ox = int(math.floor((img_box.x1 - w / 2) * 1.0 * TW / w))
                    else:
                        # left
                        actual_ox = int(math.floor((img_box.x1) * 1.0 * TW / w))
                    actual_oy = int(math.floor(img_box.y1*1.0*TH/h))
                    save_img.paste(reg, (actual_ox, actual_oy, actual_ox+actual_w, actual_oy+actual_h))

                    carr = n.split("_")
                    cur_gname = lh_gname
                    if len(carr)>=3:
                        cur_gname = carr[2]
                    save_img.save("%s/lh_%s_%s_%s_%s.png" % (OUTPUT_DIR, lh_n, lh_gid, cur_gname, carr[1]))

            # face process
            for face in face_group.layers:
                n = face.name
                t = face.kind

                if t == "pixel" and n.startswith("f"):
                    inner_face_bbox = face.bbox

                    actual_img_w = int(math.floor(face_bbox.width * TW / w))
                    actual_img_h = int(math.floor(face_bbox.height * TH / h))
                    save_img = Image.new('RGBA', (actual_img_w, actual_img_h), (255, 255, 255, 0))
                    face_img = face.as_PIL()
                    actual_w = int(math.floor(face_img.size[0]*1.0 * TW / w))
                    actual_h = int(math.floor(face_img.size[1]*1.0 * TH / h))
                    face_img = face_img.resize((actual_w, actual_h), Image.ANTIALIAS)

                    actual_ox = int(math.floor((inner_face_bbox.x1-face_bbox.x1)*1.0*TW/w))
                    actual_oy = int(math.floor((inner_face_bbox.y1-face_bbox.y1)*1.0*TH/h))
                    save_img.paste(face_img, (actual_ox, actual_oy, actual_ox+actual_w, actual_oy+actual_h))

                    save_img.save("%s/lh_%s_f_%s_%s.png" % (OUTPUT_DIR, lh_n, lh_gid, n[1:]))

            info_file_n = "%s/lh_%s_info_%s" % (OUTPUT_DIR, lh_n, lh_gid)

            cont_x = 0
            if face_bbox.x1>w/2:
                # right
                cont_x = int(math.floor((face_bbox.x1 - w / 2) * 1.0 * TW / w))
            else:
                # left
                cont_x = int(math.floor((face_bbox.x1) * 1.0 * TW / w))

            cont_y = int(math.floor(face_bbox.y1*1.0*TH/h))
            cont = "x: %d\ny: %d\n" % (cont_x, cont_y)
            with open(info_file_n, 'w') as of:
                of.write(cont.encode('utf-8'))




