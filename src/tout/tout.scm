
;;(use posix)
;;(use extras)
(use posix-extras)

(define (%separate-stime-line l)
  (call-with-input-string
   l
   (lambda(s)
     (let*((t (read s))
	   (l (read-line s)) )
       (if (eq? l #!eof) (set! l ""))
       (cons t l) ))))

(define (%static-read-sleep-out s iport oport)
  (let loop ((l (read-line iport)))
    (cond ((string? l)
	   (sleep s)(write-line l oport)
	   (loop (read-line iport)) )
	  ((eq? #!eof l) 0)
	  (else 1) )))

(define (%read-sleep-out iport oport)
  (let loop ((l (read-line iport)))
    (cond ((string? l)
	   (let((x(%separate-stime-line l))) ; this should be try-catch.
	     (sleep (car x))
	     (write-line (cdr x) oport) )
	   (loop (read-line iport)) )
	  ((eq? #!eof l) 0)
	  (else 1) )))

;; (%static-read-sleep-out 1 (current-input-port) (current-output-port))
(%read-sleep-out (current-input-port) (current-output-port))
