;;;; Simple Drag and Drop

(defun get-image-pixbuf (image)
  (ecase (gtk-image-get-storage-type image)
    (:pixbuf (gtk-image-get-pixbuf image))
    (:stock (multiple-value-bind (stock-id size)
                (gtk-image-get-stock image)
              (gtk-widget-render-icon-pixbuf image stock-id size)))))

(defun demo-simple-drag-and-drop ()
  (within-main-loop
    (let ((window (make-instance 'gtk-window
                                 :type :toplevel
                                 :title "Simple Drag and Drop"))
          (hgrid (make-instance 'gtk-grid
                                :orientation :horizontal
                                :border-width 8)))
      (g-signal-connect window "destroy"
                        (lambda (widget)
                          (declare (ignore widget))
                          (leave-gtk-main)))

      ;; Create an event box as the drag source
      (let ((image (gtk-image-new-from-stock "gtk-dialog-warning" :dialog))
            (drag-source (gtk-event-box-new)))
        (gtk-container-add drag-source image)
        (gtk-container-add hgrid drag-source)

        ;; Make drag-source a drag source
        (gtk-drag-source-set drag-source '(:button1-mask) nil '(:copy))
        (gtk-drag-source-add-image-targets drag-source)

        (g-signal-connect drag-source "drag-begin"
           (lambda (widget context)
             (format t "DRAG-BEGIN for drag-source ~A~%" context)
             (let ((pixbuf (get-image-pixbuf image)))
               ;; Sets pixbuf of image as the icon for a given drag
               (gtk-drag-set-icon-pixbuf context pixbuf 0 0))))

        (g-signal-connect drag-source "drag-data-get"
           (lambda (widget context selection-data info time)
             (declare (ignore context info time))
             (let ((pixbuf (get-image-pixbuf image)))
               (if (gtk-selection-data-set-pixbuf selection-data pixbuf)
                   (format t "DRAG-DATA-GET for drag-source ~a~%" selection-data)))
             nil))

        ;; Create a button as the drag destination
        (let ((drag-dest (make-instance 'gtk-button
                                        :always-show-image t
                                        :label "Drop the image on the Button")))
          (gtk-container-add hgrid drag-dest)

          ;; accept drops on drag-dest
          (gtk-drag-dest-set drag-dest '(:all) nil '(:copy))
          (gtk-drag-dest-add-image-targets drag-dest)

          (g-signal-connect drag-dest "drag-data-received"
            (lambda (widget context x y selection-data info time)
              (declare (ignore widget context x y info time))
              (format t "DRAG-DATA-RECEIVED ~a~%" selection-data)
              (let* ((pixbuf (gtk-selection-data-get-pixbuf selection-data))
                     (image (gtk-image-new-from-pixbuf pixbuf)))
                (gtk-button-set-image widget image)))))
        (gtk-container-add window hgrid))
      (gtk-widget-show-all window))))

