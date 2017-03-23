(in-package :mu-cl-resources)

;;;;
;; NOTE
;; docker-compose stop; docker-compose rm; docker-compose up
;; after altering this file.

;; Describe your resources here

;; The general structure could be described like this:
;;
;; (define-resource <name-used-in-this-file> ()
;;   :class <class-of-resource-in-triplestore>
;;   :properties `((<json-property-name-one> <type-one> ,<triplestore-relation-one>)
;;                 (<json-property-name-two> <type-two> ,<triplestore-relation-two>>))
;;   :has-many `((<name-of-an-object> :via ,<triplestore-relation-to-objects>
;;                                    :as "<json-relation-property>")
;;               (<name-of-an-object> :via ,<triplestore-relation-from-objects>
;;                                    :inverse t ; follow relation in other direction
;;                                    :as "<json-relation-property>"))
;;   :has-one `((<name-of-an-object :via ,<triplestore-relation-to-object>
;;                                  :as "<json-relation-property>")
;;              (<name-of-an-object :via ,<triplestore-relation-from-object>
;;                                  :as "<json-relation-property>"))
;;   :resource-base (s-url "<string-to-which-uuid-will-be-appended-for-uri-of-new-items-in-triplestore>")
;;   :on-path "<url-path-on-which-this-resource-is-available>")


;; An example setup with a catalog, dataset, themes would be:
;;
;; (define-resource catalog ()
;;   :class (s-prefix "dcat:Catalog")
;;   :properties `((:title :string ,(s-prefix "dct:title")))
;;   :has-many `((dataset :via ,(s-prefix "dcat:dataset")
;;                        :as "datasets"))
;;   :resource-base (s-url "http://webcat.tmp.semte.ch/catalogs/")
;;   :on-path "catalogs")

(define-resource blog-post-comment()
    :class (s-prefix "ext:BlogPostComment")
    :properties `((:author :string ,(s-prefix "ext:author"))
                  (:content :string ,(s-prefix "ext:content")))
    :has-one `((blog-post :via ,(s-prefix "ext:hasComment")
                          :inverse t
                          :as "blog-post"))
    :resource-base (s-url "http://fastbootexample.mu.semte.ch/blog-post-comments/")
    :on-path "blog-post-comments")

(define-resource blog-post()
    :class (s-prefix "ext:BlogPost")
    :properties `((:author :string ,(s-prefix "ext:author"))
                  (:title  :string ,(s-prefix "ext:title"))
                  (:content :string ,(s-prefix "ext:content")))
    :has-many `((blog-post-comment :via ,(s-prefix "ext:hasComment")
                         :as "comments"))
    :resource-base (s-url "http://fastbootexample.mu.semte.ch/blog-posts/")
    :on-path "blog-posts")
