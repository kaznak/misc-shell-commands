
;;(use posix)
;;(use extras)
(use posix-extras)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (%separate-stime-line line)
  (call-with-input-string
   line
   (lambda(s)
     (let*((t (read s))
	   (l (read-line s)) )
       (if (eq? l #!eof)
	   (cons t "")
	   (cons t l) )
       ))))

(define (timed-out line)
  (let((x(%separate-stime-line line))) ; this should be try-catch.
    (sleep (car x))
    (cdr x) ))

(define (timed-out-static s line)
  (sleep s)
  line  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (process-line func iport oport)
  (let loop ((l (read-line iport)))
    (cond ((string? l)
	   (write-line (func l) oport)
	   (loop (read-line iport)) )
	  ((eq? #!eof l) 0)
	  (else 1) )))

(define (%static-read-sleep-out s iport oport)
  (process-line (lambda(l)(timed-out-static s l)) iport oport) )

(define (%read-sleep-out iport oport)
  (process-line timed-out iport oport) )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (%static-read-sleep-out 1 (current-input-port) (current-output-port))
(%read-sleep-out (current-input-port) (current-output-port))
