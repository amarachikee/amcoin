;; SIP-010 Fungible Token Standard Trait
;;
;; This contract defines the SIP-010 trait that fungible tokens can implement.
;; AMCOIN implements this trait in `contracts/amcoin.clar`.

(define-trait sip-010-ft-standard
  (
    ;; Transfer `amount` tokens from `sender` to `recipient`.
    ;; The optional memo is commonly used by clients, but is not interpreted by the standard.
    (transfer (uint principal principal (optional (buff 34))) (response bool uint))

    ;; Token metadata
    (get-name () (response (string-ascii 32) uint))
    (get-symbol () (response (string-ascii 10) uint))
    (get-decimals () (response uint uint))

    ;; Supply & balances
    (get-balance (principal) (response uint uint))
    (get-total-supply () (response uint uint))

    ;; Optional token metadata URI (e.g. to a JSON resource)
    (get-token-uri () (response (optional (string-utf8 256)) uint))
  )
)
