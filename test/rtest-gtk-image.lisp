(def-suite gtk-image :in gtk-suite)
(in-suite gtk-image)

;;; --- Types and Values -------------------------------------------------------

;;;     GtkImageType

(test gtk-image-type
  ;; Check the type
  (is-true (g-type-is-enum "GtkImageType"))
  ;; Check the type initializer
  (is (string= "GtkImageType"
               (g-type-name (gtype (foreign-funcall "gtk_image_type_get_type" :int)))))
  ;; Check the registered name
  (is (eq 'gtk-image-type (gobject::registered-enum-type "GtkImageType")))
  ;; Check the names
  (is (equal '("GTK_IMAGE_EMPTY" "GTK_IMAGE_PIXBUF" "GTK_IMAGE_STOCK" "GTK_IMAGE_ICON_SET"
               "GTK_IMAGE_ANIMATION" "GTK_IMAGE_ICON_NAME" "GTK_IMAGE_GICON"
               "GTK_IMAGE_SURFACE")
             (mapcar #'gobject::enum-item-name
                     (gobject::get-enum-items "GtkImageType"))))
  ;; Check the values
  (is (equal '(0 1 2 3 4 5 6 7)
             (mapcar #'gobject::enum-item-value
                     (gobject::get-enum-items "GtkImageType"))))
  ;; Check the nick names
  (is (equal '("empty" "pixbuf" "stock" "icon-set" "animation" "icon-name" "gicon" "surface")
             (mapcar #'gobject::enum-item-nick
                     (gobject::get-enum-items "GtkImageType"))))
  ;; Check the enum definition
  (is (equal '(DEFINE-G-ENUM "GtkImageType"
                             GTK-IMAGE-TYPE
                             (:EXPORT T :TYPE-INITIALIZER "gtk_image_type_get_type")
                             (:EMPTY 0)
                             (:PIXBUF 1)
                             (:STOCK 2)
                             (:ICON-SET 3)
                             (:ANIMATION 4)
                             (:ICON-NAME 5)
                             (:GICON 6)
                             (:SURFACE 7))
             (gobject::get-g-type-definition "GtkImageType"))))

;;;     GtkImage

(test gtk-image-class
  ;; Type check
  (is-true  (g-type-is-object "GtkImage"))
  ;; Check the registered name
  (is (eq 'gtk-image
          (registered-object-type-by-name "GtkImage")))
  ;; Check the type initializer
  (is (string= "GtkImage"
               (g-type-name (gtype (foreign-funcall "gtk_image_get_type" :int)))))
  ;; Check the parent
  (is (equal (gtype "GtkMisc") (g-type-parent "GtkImage")))
  ;; Check the children
  (is (equal '()
             (mapcar #'gtype-name (g-type-children "GtkImage"))))
  ;; Check the interfaces
  (is (equal '("AtkImplementorIface" "GtkBuildable")
             (mapcar #'gtype-name (g-type-interfaces "GtkImage"))))
  ;; Check the class properties
  (is (equal '("app-paintable" "can-default" "can-focus" "composite-child" "double-buffered"
               "events" "expand" "file" "focus-on-click" "gicon" "halign" "has-default"
               "has-focus" "has-tooltip" "height-request" "hexpand" "hexpand-set" "icon-name"
               "icon-set" "icon-size" "is-focus" "margin" "margin-bottom" "margin-end"
               "margin-left" "margin-right" "margin-start" "margin-top" "name" "no-show-all"
               "opacity" "parent" "pixbuf" "pixbuf-animation" "pixel-size" "receives-default"
               "resource" "scale-factor" "sensitive" "stock" "storage-type" "style" "surface"
               "tooltip-markup" "tooltip-text" "use-fallback" "valign" "vexpand"
               "vexpand-set" "visible" "width-request" "window" "xalign" "xpad" "yalign"
               "ypad")
             (stable-sort (mapcar #'param-spec-name
                                  (g-object-class-list-properties "GtkImage"))
                          #'string-lessp)))
  ;; Check the style properties.
  (is (equal '("cursor-aspect-ratio" "cursor-color" "focus-line-pattern" "focus-line-width"
               "focus-padding" "interior-focus" "link-color" "scroll-arrow-hlength"
               "scroll-arrow-vlength" "secondary-cursor-color" "separator-height"
               "separator-width" "text-handle-height" "text-handle-width"
               "visited-link-color" "wide-separators" "window-dragging")
             (mapcar #'param-spec-name
                     (gtk-widget-class-list-style-properties "GtkImage"))))
  ;; Check the class definition
  (is (equal '(DEFINE-G-OBJECT-CLASS "GtkImage" GTK-IMAGE
                       (:SUPERCLASS GTK-MISC :EXPORT T :INTERFACES
                        ("AtkImplementorIface" "GtkBuildable")
                        :TYPE-INITIALIZER "gtk_image_get_type")
                       ((FILE GTK-IMAGE-FILE "file" "gchararray" T T)
                        (GICON GTK-IMAGE-GICON "gicon" "GIcon" T T)
                        (ICON-NAME GTK-IMAGE-ICON-NAME "icon-name" "gchararray"
                         T T)
                        (ICON-SET GTK-IMAGE-ICON-SET "icon-set" "GtkIconSet" T
                         T)
                        (ICON-SIZE GTK-IMAGE-ICON-SIZE "icon-size" "gint" T T)
                        (PIXBUF GTK-IMAGE-PIXBUF "pixbuf" "GdkPixbuf" T T)
                        (PIXBUF-ANIMATION GTK-IMAGE-PIXBUF-ANIMATION
                         "pixbuf-animation" "GdkPixbufAnimation" T T)
                        (PIXEL-SIZE GTK-IMAGE-PIXEL-SIZE "pixel-size" "gint" T
                         T)
                        (RESOURCE GTK-IMAGE-RESOURCE "resource" "gchararray" T
                         T)
                        (STOCK GTK-IMAGE-STOCK "stock" "gchararray" T T)
                        (STORAGE-TYPE GTK-IMAGE-STORAGE-TYPE "storage-type"
                         "GtkImageType" T NIL)
                        (SURFACE GTK-IMAGE-SURFACE "surface" "CairoSurface" T
                         T)
                        (USE-FALLBACK GTK-IMAGE-USE-FALLBACK "use-fallback"
                         "gboolean" T T)))
             (get-g-type-definition "GtkImage"))))

;;; --- Properties -------------------------------------------------------------

(test gtk-image-properties
  (let ((image (make-instance 'gtk-image)))
    (is-false (gtk-image-file image))
    (is-false (gtk-image-gicon image))
    (is-false (gtk-image-icon-name image))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 4 (gtk-image-icon-size image)))
    (is-false (gtk-image-pixbuf image))
    (is-false (gtk-image-pixbuf-animation image))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is-false (gtk-image-stock image))
    (is (eq :empty (gtk-image-storage-type image)))
    ;; at this point surface is a null-pointer, this causes an error
    (signals (error) (gtk-image-surface image))
    (is-false (gtk-image-use-fallback image))))

(test gtk-image-icon-size
  ;; The accessor gtk-image-icon-size is implemented with an integer.
  ;; This integer can be converted to a gtk-icon-size keyword
  (let ((image (gtk-image-new)))
    (is (eq :button (foreign-enum-keyword 'gtk-icon-size (gtk-image-icon-size image))))
    (is (= (foreign-enum-value 'gtk-icon-size :button) (gtk-image-icon-size image)))))

;;; --- Functions --------------------------------------------------------------

;;;     gtk_image_get_icon_set

(test gtk-image-get-icon-set
  (let ((image (gtk-image-new-from-icon-set (gtk-icon-factory-lookup-default "gtk-ok") :dialog)))
    (is (eq 'gtk-image (type-of image)))
    (is (eq 'gtk-icon-set (type-of (gtk-image-get-icon-set image))))
    (multiple-value-bind (icon-set icon-size)
        (gtk-image-get-icon-set image)
      (is (eq 'gtk-icon-set (type-of icon-set)))
      (is (eq :dialog icon-size)))))

;;;     gtk_image_get_stock

(test gtk-image-get-stock
  (let ((image (gtk-image-new-from-stock "gtk-ok" :dialog)))
    (is (eq 'gtk-image (type-of image)))
    (is (string= "gtk-ok" (gtk-image-get-stock image)))
    (multiple-value-bind (icon-set icon-size)
        (gtk-image-get-stock image)
      (is (string= "gtk-ok" icon-set))
      (is (eq :dialog icon-size)))))

;;;     gtk_image_get_animation

(test gtk-image-get-animation
  (let* ((animation (gdk-pixbuf-animation-new-from-file "floppybuddy.gif"))
         (image (gtk-image-new-from-animation animation)))
    (is (eq 'gtk-image (type-of image)))
    (is (eq 'gdk-pixbuf-animation (type-of (gtk-image-get-animation image))))))

;;;     gtk_image_get_icon_name

(test gtk-image-get-icon-name
  (let ((image (gtk-image-new-from-icon-name "gtk-ok" :dialog)))
    (is (eq 'gtk-image (type-of image)))
    (is (string= "gtk-ok" (gtk-image-get-icon-name image)))
    (multiple-value-bind (icon-set icon-size)
        (gtk-image-get-icon-name image)
      (is (string= "gtk-ok" icon-set))
      (is (eq :dialog icon-size)))))

;;;     gtk_image_get_gicon

(test gtk-image-get-gicon
  (let* ((icon (g-themed-icon-new-from-names "gtk-ok"))
         (image (gtk-image-new-from-gicon icon :dialog)))
    (is (eq 'gtk-image (type-of image)))
    (is (eq 'g-themed-icon (type-of (gtk-image-gicon image))))
    (multiple-value-bind (icon-set icon-size)
        (gtk-image-get-gicon image)
      (is (eq 'g-themed-icon (type-of icon-set)))
      (is (eq :dialog icon-size)))))

;;;     gtk_image_new_from_file

(test gtk-image-new-from-file
  (let ((image (gtk-image-new-from-file "gtk-logo-24.png")))
    (is (eq 'gtk-image (type-of image)))
    (is (string= "gtk-logo-24.png" (gtk-image-file image)))
    (is-false (gtk-image-gicon image))
    (is-false (gtk-image-icon-name image))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 0 (gtk-image-icon-size image)))
    (is (eq 'gdk-pixbuf (type-of (gtk-image-pixbuf image))))
    (is-false (gtk-image-pixbuf-animation image))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is-false (gtk-image-stock image))
    (is (eq :pixbuf (gtk-image-storage-type image)))
    ;; at this point surface is a null-pointer, this causes an error
    (signals (error) (gtk-image-surface image))
    (is-false (gtk-image-use-fallback image))))

;;;     gtk_image_new_from_icon_set

(test gtk-image-new-from-icon-set
  (let ((image (gtk-image-new-from-icon-set (gtk-icon-factory-lookup-default "gtk-ok") :dialog)))
    (is (eq 'gtk-image (type-of image)))
    (is-false (gtk-image-file image))
    (is-false (gtk-image-gicon image))
    (is-false (gtk-image-icon-name image))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 6 (gtk-image-icon-size image)))
    (is-false (gtk-image-pixbuf image))
    (is-false (gtk-image-pixbuf-animation image))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is-false (gtk-image-stock image))
    (is (eq :icon-set (gtk-image-storage-type image)))
    ;; at this point surface is a null-pointer, this causes an error
    (signals (error) (gtk-image-surface image))
    (is-false (gtk-image-use-fallback image))))

;;;     gtk_image_new_from_pixbuf

(test gtk-image-new-from-pixbuf
  (let* ((pixbuf (gdk-pixbuf-new-from-file "gtk-logo-24.png"))
         (image (gtk-image-new-from-pixbuf pixbuf)))
    (is (eq 'gtk-image (type-of image)))
    (is-false (gtk-image-file image))
    (is-false (gtk-image-gicon image))
    (is-false (gtk-image-icon-name image))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 0 (gtk-image-icon-size image)))
    (is (eq 'gdk-pixbuf (type-of (gtk-image-pixbuf image))))
    (is-false (gtk-image-pixbuf-animation image))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is-false (gtk-image-stock image))
    (is (eq :pixbuf (gtk-image-storage-type image)))
    ;; at this point surface is a null-pointer, this causes an error
    (signals (error) (gtk-image-surface image))
    (is-false (gtk-image-use-fallback image))))

;;;     gtk_image_new_from_stock

(test gtk-image-new-from-stock
  (let ((image (gtk-image-new-from-stock "gtk-ok" :dialog)))
    (is (eq 'gtk-image (type-of image)))
    (is-false (gtk-image-file image))
    (is-false (gtk-image-gicon image))
    (is-false (gtk-image-icon-name image))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 6 (gtk-image-icon-size image)))
    (is-false (gtk-image-pixbuf image))
    (is-false (gtk-image-pixbuf-animation image))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is (string= "gtk-ok" (gtk-image-stock image)))
    (is (eq :stock (gtk-image-storage-type image)))
    ;; at this point surface is a null-pointer, this causes an error
    (signals (error) (gtk-image-surface image))
    (is-false (gtk-image-use-fallback image))))

;;;     gtk_image_new_from_animation

(test gtk-image-new-from-animation
  (let* ((animation (gdk-pixbuf-animation-new-from-file "floppybuddy.gif"))
         (image (gtk-image-new-from-animation animation)))
    (is (eq 'gtk-image (type-of image)))
    (is-false (gtk-image-file image))
    (is-false (gtk-image-gicon image))
    (is-false (gtk-image-icon-name image))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 0 (gtk-image-icon-size image)))
    (is-false (gtk-image-pixbuf image))
    (is (eq 'gdk-pixbuf-animation (type-of (gtk-image-pixbuf-animation image))))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is-false (gtk-image-stock image))
    (is (eq :animation (gtk-image-storage-type image)))
    ;; at this point surface is a null-pointer, this causes an error
    (signals (error) (gtk-image-surface image))
    (is-false (gtk-image-use-fallback image))))

;;;     gtk_image_new_from_icon_name

(test gtk-image-new-from-icon-name
  (let ((image (gtk-image-new-from-icon-name "gtk-ok" :dialog)))
    (is (eq 'gtk-image (type-of image)))
    (is-false (gtk-image-file image))
    (is-false (gtk-image-gicon image))
    (is (string= "gtk-ok" (gtk-image-icon-name image)))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 6 (gtk-image-icon-size image)))
    (is-false (gtk-image-pixbuf image))
    (is-false (gtk-image-pixbuf-animation image))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is-false (gtk-image-stock image))
    (is (eq :icon-name (gtk-image-storage-type image)))
    ;; at this point surface is a null-pointer, this causes an error
    (signals (error) (gtk-image-surface image))
    (is-false (gtk-image-use-fallback image))))

;;;     gtk_image_new_from_gicon

(test gtk-image-new-from-gicon
  (let* ((icon (g-themed-icon-new-from-names "gtk-ok"))
         (image (gtk-image-new-from-gicon icon :dialog)))
    (is (eq 'gtk-image (type-of image)))
    (is-false (gtk-image-file image))
    (is (eq 'g-themed-icon (type-of (gtk-image-gicon image))))
    (is-false (gtk-image-icon-name image))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 6 (gtk-image-icon-size image)))
    (is-false (gtk-image-pixbuf image))
    (is-false (gtk-image-pixbuf-animation image))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is-false (gtk-image-stock image))
    (is (eq :gicon (gtk-image-storage-type image)))
    ;; at this point surface is a null-pointer, this causes an error
    (signals (error) (gtk-image-surface image))
    (is-false (gtk-image-use-fallback image))))

;;;     gtk_image_new_from_resource

;; TODO: There is something wrong with the gresources file.

(test gtk-image-new-from-resource
  (let ((image (gtk-image-new-from-resource "gtk-logo-24.png")))
    (is (eq 'gtk-image (type-of image)))
    (is-false (gtk-image-file image))
    (is-false (gtk-image-gicon image))
    (is (string= "image-missing" (gtk-image-icon-name image)))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 4 (gtk-image-icon-size image)))
    (is-false (gtk-image-pixbuf image))
    (is-false (gtk-image-pixbuf-animation image))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is-false (gtk-image-stock image))
    (is (eq :icon-name (gtk-image-storage-type image)))
    ;; at this point surface is a null-pointer, this causes an error
    (signals (error) (gtk-image-surface image))
    (is-false (gtk-image-use-fallback image))))

;;;     gtk_image_new_from_surface ()

(test gtk-image-new-from-surface
  (let* ((theme (gtk-icon-theme-default))
         (surface (gtk-icon-theme-load-surface theme "gtk-ok" 48 1 nil :use-builtin))
         (image (gtk-image-new-from-surface surface)))
    (is (eq 'gtk-image (type-of image)))
    (is-false (gtk-image-file image))
    (is-false (gtk-image-gicon image))
    (is-false (gtk-image-icon-name image))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 0 (gtk-image-icon-size image)))
    (is-false (gtk-image-pixbuf image))
    (is-false (gtk-image-pixbuf-animation image))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is-false (gtk-image-stock image))
    (is (eq :surface (gtk-image-storage-type image)))
    ;; we have a valid Cairo surface
    (is (eq 'cairo-surface (type-of (gtk-image-surface image))))
    (is-false (gtk-image-use-fallback image))))

;;;     gtk_image_set_from_file

(test gtk-image-set-from-file
  (let ((image (make-instance 'gtk-image)))
    ;; Set image from file
    (is-false (gtk-image-set-from-file image "gtk-logo-24.png"))
    ;; Check the properties
    (is (eq 'gtk-image (type-of image)))
    (is (string= "gtk-logo-24.png" (gtk-image-file image)))
    (is-false (gtk-image-gicon image))
    (is-false (gtk-image-icon-name image))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 0 (gtk-image-icon-size image)))
    (is (eq 'gdk-pixbuf (type-of (gtk-image-pixbuf image))))
    (is-false (gtk-image-pixbuf-animation image))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is-false (gtk-image-stock image))
    (is (eq :pixbuf (gtk-image-storage-type image)))
    ;; at this point surface is a null-pointer, this causes an error
    (signals (error) (gtk-image-surface image))
    (is-false (gtk-image-use-fallback image))))

;;;     gtk_image_set_from_icon_set

(test gtk-image-set-from-icon-set
  (let ((image (make-instance 'gtk-image)))
    ;; Set image from icon set
    (is-false (gtk-image-set-from-icon-set image (gtk-icon-factory-lookup-default "gtk-ok") :dialog))
    ;; Check the properties
    (is (eq 'gtk-image (type-of image)))
    (is-false (gtk-image-file image))
    (is-false (gtk-image-gicon image))
    (is-false (gtk-image-icon-name image))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 6 (gtk-image-icon-size image)))
    (is-false (gtk-image-pixbuf image))
    (is-false (gtk-image-pixbuf-animation image))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is-false (gtk-image-stock image))
    (is (eq :icon-set (gtk-image-storage-type image)))
    ;; at this point surface is a null-pointer, this causes an error
    (signals (error) (gtk-image-surface image))
    (is-false (gtk-image-use-fallback image))))

;;;     gtk_image_set_from_pixbuf

(test gtk-image-set-from-pixbuf
  (let ((pixbuf (gdk-pixbuf-new-from-file "gtk-logo-24.png"))
        (image (make-instance 'gtk-image)))
    ;; Set image from pixbuf
    (is-false (gtk-image-set-from-pixbuf image pixbuf))
    ;; Check the properties
    (is (eq 'gtk-image (type-of image)))
    (is-false (gtk-image-file image))
    (is-false (gtk-image-gicon image))
    (is-false (gtk-image-icon-name image))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 0 (gtk-image-icon-size image)))
    (is (eq 'gdk-pixbuf (type-of (gtk-image-pixbuf image))))
    (is-false (gtk-image-pixbuf-animation image))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is-false (gtk-image-stock image))
    (is (eq :pixbuf (gtk-image-storage-type image)))
    ;; at this point surface is a null-pointer, this causes an error
    (signals (error) (gtk-image-surface image))
    (is-false (gtk-image-use-fallback image))))

;;;     gtk_image_set_from_stock

(test gtk-image-set-from-stock
  (let ((image (make-instance 'gtk-image)))
    ;; Set image from stock
    (is-false (gtk-image-set-from-stock image "gtk-ok" :dialog))
    ;; Check the properties
    (is (eq 'gtk-image (type-of image)))
    (is-false (gtk-image-file image))
    (is-false (gtk-image-gicon image))
    (is-false (gtk-image-icon-name image))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 6 (gtk-image-icon-size image)))
    (is-false (gtk-image-pixbuf image))
    (is-false (gtk-image-pixbuf-animation image))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is (string= "gtk-ok" (gtk-image-stock image)))
    (is (eq :stock (gtk-image-storage-type image)))
    ;; at this point surface is a null-pointer, this causes an error
    (signals (error) (gtk-image-surface image))
    (is-false (gtk-image-use-fallback image))))

;;;     gtk_image_set_from_animation

(test gtk-image-set-from-animation
  (let ((animation (gdk-pixbuf-animation-new-from-file "floppybuddy.gif"))
        (image (make-instance 'gtk-image)))
    ;; Set image from animation
    (is-false (gtk-image-set-from-animation image animation))
    ;; Check the properties
    (is (eq 'gtk-image (type-of image)))
    (is-false (gtk-image-file image))
    (is-false (gtk-image-gicon image))
    (is-false (gtk-image-icon-name image))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 0 (gtk-image-icon-size image)))
    (is-false (gtk-image-pixbuf image))
    (is (eq 'gdk-pixbuf-animation (type-of (gtk-image-pixbuf-animation image))))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is-false (gtk-image-stock image))
    (is (eq :animation (gtk-image-storage-type image)))
    ;; at this point surface is a null-pointer, this causes an error
    (signals (error) (gtk-image-surface image))
    (is-false (gtk-image-use-fallback image))))

;;;     gtk_image_set_from_icon_name

(test gtk-image-set-from-icon-name
  (let ((image (make-instance 'gtk-image)))
    ;; Set image from icon name
    (is-false (gtk-image-set-from-icon-name image "gtk-ok" :dialog))
    ;; Check the properties
    (is (eq 'gtk-image (type-of image)))
    (is-false (gtk-image-file image))
    (is-false (gtk-image-gicon image))
    (is (string= "gtk-ok" (gtk-image-icon-name image)))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 6 (gtk-image-icon-size image)))
    (is-false (gtk-image-pixbuf image))
    (is-false (gtk-image-pixbuf-animation image))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is-false (gtk-image-stock image))
    (is (eq :icon-name (gtk-image-storage-type image)))
    ;; at this point surface is a null-pointer, this causes an error
    (signals (error) (gtk-image-surface image))
    (is-false (gtk-image-use-fallback image))))

;;;     gtk_image_set_from_gicon

(test gtk-image-set-from-gicon
  (let ((icon (g-themed-icon-new-from-names "gtk-ok"))
        (image (make-instance 'gtk-image)))
    ;; Set image from gicon
    (is-false (gtk-image-set-from-gicon image icon :dialog))
    ;; Check the properties
    (is (eq 'gtk-image (type-of image)))
    (is-false (gtk-image-file image))
    (is (eq 'g-themed-icon (type-of (gtk-image-gicon image))))
    (is-false (gtk-image-icon-name image))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 6 (gtk-image-icon-size image)))
    (is-false (gtk-image-pixbuf image))
    (is-false (gtk-image-pixbuf-animation image))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is-false (gtk-image-stock image))
    (is (eq :gicon (gtk-image-storage-type image)))
    ;; at this point surface is a null-pointer, this causes an error
    (signals (error) (gtk-image-surface image))
    (is-false (gtk-image-use-fallback image))))

;;;     gtk_image_set_from_resource

;; TODO: There is something wrong with the gresources file.

(test gtk-image-set-from-resource
  (let ((image (gtk-image-new)))
    ;; Set image for resource
    (is-false (gtk-image-set-from-resource image "gtk-logo-24.png"))
    ;; Check the properties
    (is (eq 'gtk-image (type-of image)))
    (is-false (gtk-image-file image))
    (is-false (gtk-image-gicon image))
    (is (string= "image-missing" (gtk-image-icon-name image)))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 4 (gtk-image-icon-size image)))
    (is-false (gtk-image-pixbuf image))
    (is-false (gtk-image-pixbuf-animation image))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is-false (gtk-image-stock image))
    (is (eq :icon-name (gtk-image-storage-type image)))
    ;; at this point surface is a null-pointer, this causes an error
    (signals (error) (gtk-image-surface image))
    (is-false (gtk-image-use-fallback image))))

;;;     gtk_image_set_from_surface ()

(test gtk-image-set-from-surface
  (let* ((theme (gtk-icon-theme-default))
         (surface (gtk-icon-theme-load-surface theme "gtk-ok" 48 1 nil :use-builtin))
         (image (make-instance 'gtk-image)))
    ;; Set image from surface
    (is-false (gtk-image-set-from-surface image surface))
    ;; Check the properties
    (is (eq 'gtk-image (type-of image)))
    (is-false (gtk-image-file image))
    (is-false (gtk-image-gicon image))
    (is-false (gtk-image-icon-name image))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 0 (gtk-image-icon-size image)))
    (is-false (gtk-image-pixbuf image))
    (is-false (gtk-image-pixbuf-animation image))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is-false (gtk-image-stock image))
    (is (eq :surface (gtk-image-storage-type image)))
    ;; we have a valid Cairo surface
    (is (eq 'cairo-surface (type-of (gtk-image-surface image))))
    (is-false (gtk-image-use-fallback image))))

;;;     gtk_image_clear

(test gtk-image-clear
  (let ((image (gtk-image-new-from-icon-name "gtk-ok" 4)))

    ;; Create image from icon name
    (is (eq 'gtk-image (type-of image)))
    (is-false (gtk-image-file image))
    (is-false (gtk-image-gicon image))
    (is (string= "gtk-ok" (gtk-image-icon-name image)))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 4 (gtk-image-icon-size image)))
    (is-false (gtk-image-pixbuf image))
    (is-false (gtk-image-pixbuf-animation image))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is-false (gtk-image-stock image))
    (is (eq :icon-name (gtk-image-storage-type image)))
    ;; at this point surface is a null-pointer, this causes an error
    (signals (error) (gtk-image-surface image))
    (is-false (gtk-image-use-fallback image))

    ;; Clear the image
    (is-false (gtk-image-clear image))
    (is (eq 'gtk-image (type-of image)))
    (is-false (gtk-image-file image))
    (is-false (gtk-image-gicon image))
    (is-false (gtk-image-icon-name image))
    (is (eq 'gtk-icon-set (type-of (gtk-image-icon-set image))))
    (is (= 0 (gtk-image-icon-size image)))
    (is-false (gtk-image-pixbuf image))
    (is-false (gtk-image-pixbuf-animation image))
    (is (= -1 (gtk-image-pixel-size image)))
    (is-false (gtk-image-resource image))
    (is-false (gtk-image-stock image))
    (is (eq :empty (gtk-image-storage-type image)))
    ;; at this point surface is a null-pointer, this causes an error
    (signals (error) (gtk-image-surface image))
    (is-false (gtk-image-use-fallback image))))

;;;     gtk_image_new

(test gtk-image-new
  (is (eq 'gtk-image (type-of (gtk-image-new)))))

