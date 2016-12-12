
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

(define (timed-out delay line)
  (let*((sleep-line (%separate-stime-line line)) ; this should be try-catch.
        (new-delay  (sleep (- (car sleep-line) delay))) )
    (cons new-delay (cdr sleep-line)) ))

(define (timed-out-static sleep-sec deleay line)
  (let*((new-delay  (sleep (- sleep-sec delay))))
    (cons new-delay (cdr sleep-line)) ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (process-line func init-state iport oport)
  (let loop ((state init-state)(line (read-line iport)))
    (cond ((string? line)
	   (let((x (func state line)))
	     (write-line (cdr x) oport)
	     (loop (car x) (read-line iport)) ))
	  ((eq? #!eof line) 0)
	  (else 1) )))

(define (%read-sleep-out-static sleep-sec iport oport)
  (process-line (lambda(delay line)(timed-out-static sleep-sec delay line))
		0 iport oport ))

(define (%read-sleep-out iport oport)
  (process-line timed-out 0 iport oport) )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (%static-read-sleep-out 1 (current-input-port) (current-output-port))
(%read-sleep-out (current-input-port) (current-output-port))
