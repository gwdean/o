Scheme
------
Code in this section was adapted from Gerald Jay Sussman
and Jack Wisdom's *Functional Differential Geometry*.

## Procedure Calls
    
	(+ 1 2.14) ;=> 3.14
    (+ 1 (* 2 1.07)) ;=> 3.14

    ( _operator_ _operand-1_ ... _operand-2_ )

## Lambda Expressions

    (lambda (x) (* x x))
	
	((lambda (x) (* x x)) 4) ;=> 16
	
	(lambda /formal-parameters body/)
	
## Definitions

    (define pi 3.1415926...)
	
	(define square (lambda (x) (* x x)))
	
	(* 4 pi (square 5)) ;=> 314.159...
	
	(define (square x) (* x x))
	
    (define compose
	  (lambda (f g)
	    (lambda (x)
		  (f (g x)))))
		  
	((compose square sin) 2) ;=> .8268...
	
	(square (sin 2)) ;=> .8268...
	
	(define (compose f g)
	  (lambda (x)
	    (f (g x))))

    (define ((compose f g) x)
	  (f (g x)))
	    
## Conditionals

    (define (abs x)
	  (cond ((< x 0) (- x))
		    ((= x 0) x)
			((> x 0) x)))
			
	(cond ( /predicate-1 consequent-1/)
		  ...
		  ( /predicate-n consequent-n/))
	
	(define (abs x)
	  (if (< x 0)
		  (- x)
		  x))
	
	(if /predicate/ /consequent/ /alternative/)

## Recursive Procedures
    
	(define (factorial n)
	  (if (= n 0)
		  1
		  (* n (factorial (- n 1)))))
	
	(factorial 6) ;=> 720
	
	(factorial 40) ;=> 8159...(very long)...000

## Local Names

    (define (factorial n)
      (let factlp ((count 1) (answer 1))
	    (if (> count n)
			answer
			(factlp (+ count 1) (+ count answer)))))
			
	(factorial 6) ;=> 720
	
## Compound Data -- Lists and Vectors

    (define a-list (list 6 946 8 356 12 620))
	
	a-list ;=> (6 946 8 356 12 620)
	
	(list-ref a-list 3) ;=> 356
	
	(list-ref a-list 0) ;=> 6
	
	(car a-list) ;=> 6
	
	(cdr a-list) ;=> (946 8 356 12 620)
	
	(car (cdr a-list)) ;=> 946
	
	(define another-list
	  (cons 32 (cdr a-list)))
	
	another-list ;=> (32 946 8 356 12 620)
	
	(car (cdr another-list)) ;=> 946
	
	(define a-vector
	  (vector 37 63 49 21 88 56))
	
	a-vector ;=> #(37 63 49 21 88 56)
	
	(vector-ref a-vector 3) ;=> 21
	
	(vector-ref a-vector 0) ;=> 37
	
## Symbols

    (define (sum? expression)
	  (and (pair? expression)
		   (eq? (car expression) '+)))
	
	(sum? '(+ 3 a)) ;=> #t
	
	(sum? '(* 3 a)) ;=> #f
	
## Links to Markdown Sources

Thus, "Markdown" is two things: (1) a plain text formatting syntax;
and (2) a software tool, written in Perl, that converts the plain text
formatting to HTML. See the [Syntax][] page for details pertaining to
Markdown's formatting syntax. You can try it out, right now, using the
online [Dingus][].

  [syntax]: /projects/markdown/syntax
  [dingus]: /projects/markdown/dingus
<http://daringfireball.net/projects/markdown/index.text>

(You can use this '.text' suffix trick to view the Markdown source for
the content of each of the pages in this section, e.g. the
[Syntax][s_src] and [License][l_src] pages.)

  [s_src]: /projects/markdown/syntax.text
  [l_src]: /projects/markdown/license.text

Markdown is free software, available under a BSD-style open source
license. See the [License] [pl] page for more information.

  [pl]: /projects/markdown/license


Acknowledgements <a id="acknowledgements" />
----------------

[Aaron Swartz][] deserves a tremendous amount of credit for his feedback on the
design of Markdown's formatting syntax. Markdown is *much* better thanks
to Aaron's ideas, feedback, and testing. Also, Aaron's [html2text][]
is a very handy (and free) utility for turning HTML into
Markdown-formatted plain text.

[Nathaniel Irons][], [Dan Benjamin][], [Daniel Bogan][], and [Jason Perkins][]
also deserve thanks for their feedback.

[Michel Fortin][] has ported Markdown to PHP; it's a splendid port, and highly recommended for anyone looking for a PHP implementation of Markdown.

  [Aaron Swartz]:		http://www.aaronsw.com/
  [Nathaniel Irons]:	http://bumppo.net/
  [Dan Benjamin]:		http://hivelogic.com/
  [Daniel Bogan]:		http://waferbaby.com/
  [Jason Perkins]:		http://pressedpants.com/
  [Michel Fortin]:		http://www.michelf.com/projects/php-markdown/
  [html2text]:          http://www.aaronsw.com/2002/html2text/
 
  [tfmenu]: /graphics/markdown/mt_textformat_menu.png
