;; AMCOIN (SIP-010 Fungible Token)
;;
;; A simple fungible token implementation for the Stacks blockchain.
;; - Implements the SIP-010 FT trait.
;; - Supports owner-controlled minting.
;; - Enforces that `transfer` can only be initiated by the `sender`.

(impl-trait .sip-010-ft-trait.sip-010-ft-standard)

;; Token definition
(define-fungible-token amcoin)

;; Error codes (project-level, stable)
(define-constant ERR_NOT_AUTHORIZED (err u100))
(define-constant ERR_INVALID_AMOUNT (err u102))
(define-constant ERR_INSUFFICIENT_BALANCE (err u101))

;; Token metadata (SIP-010)
(define-constant TOKEN_NAME "AMCoin")
(define-constant TOKEN_SYMBOL "AMCOIN")
(define-constant TOKEN_DECIMALS u6)

;; Owner (initially: contract deployer)
(define-data-var owner principal tx-sender)

;; -------------------------
;; Public (admin)
;; -------------------------

(define-public (set-owner (new-owner principal))
  (begin
    (asserts! (is-eq tx-sender (var-get owner)) ERR_NOT_AUTHORIZED)
    (var-set owner new-owner)
    (ok true)
  )
)

(define-public (mint (amount uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender (var-get owner)) ERR_NOT_AUTHORIZED)
    (asserts! (> amount u0) ERR_INVALID_AMOUNT)
    (ft-mint? amcoin amount recipient)
  )
)

;; -------------------------
;; SIP-010 required functions
;; -------------------------

(define-public (transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34))))
  (begin
    (asserts! (> amount u0) ERR_INVALID_AMOUNT)
    (asserts! (is-eq tx-sender sender) ERR_NOT_AUTHORIZED)

    ;; Note: memo is accepted for standard compatibility; AMCOIN does not interpret it.
    (match (ft-transfer? amcoin amount sender recipient)
      transferred (ok transferred)
      err-code ERR_INSUFFICIENT_BALANCE
    )
  )
)

(define-read-only (get-name)
  (ok TOKEN_NAME)
)

(define-read-only (get-symbol)
  (ok TOKEN_SYMBOL)
)

(define-read-only (get-decimals)
  (ok TOKEN_DECIMALS)
)

(define-read-only (get-balance (who principal))
  (ok (ft-get-balance amcoin who))
)

(define-read-only (get-total-supply)
  (ok (ft-get-supply amcoin))
)

(define-read-only (get-token-uri)
  ;; Set to none by default. If you have a metadata URL, return (some u"...").
  (ok none)
)

;; -------------------------
;; Additional helpers
;; -------------------------

(define-read-only (get-owner)
  (var-get owner)
)
