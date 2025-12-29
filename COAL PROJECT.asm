org 100h

.data
    ; ======================================================
    ; MESSAGES AND UI STRINGS
    ; ======================================================
    
    ; Welcome Page Header
    a1  db 10,13,'******************* Welcome   *******************$'
    a2  db 10,13,'xx          To          xx$'
    a3  db 10,13,'xx      Online Book      xx$'
    a4  db 10,13,'xx          Shop          xx$'
    a5  db 10,13,'******************* *******************$'

    ; User Interaction Prompts
    a7  db 10,13,'Book List:- $'
    a8  db 10,13,'Enter Your Choice:- $'
    a19 db 10,13,'Enter 1 to Display Books List: $'
    a34 db 10,13,'Select Book Number: $'
    a35 db 10,13,'Enter Quantity: $'
    a36 db 10,13,'Invalid Input !! Rerun the Program$'
    a37 db 10,13,'Total Price: $'
    a38 db 10,13,10,13,'1. Go to Main Menu$'
    a39 db 10,13,'2. Exit$'

    ; English Novels List (Price: 50)
    a12 db 10,13,'**************** English Novels List  ****************$'
    a13 db 10,13,'1.Gathering Rights         50/-$'
    a14 db 10,13,'2.Middle March             50/-$'
    a15 db 10,13,'3.Nineteen EightyFour      50/-$'
    a16 db 10,13,'4.The Queen of the Ring    50/-$'
    a17 db 10,13,'5.Diary of a Nobody        50/-$'
    a18 db 10,13,'6.His Dark Materials       50/-$'

    ; Urdu Novels List (Price: 100)
    a20 db 10,13,'**************** Urdu Novels List  ****************$'
    a21 db 10,13,'1.Janat kay pattay         100/-$'
    a22 db 10,13,'2.Laa-Hasil                100/-$'
    a23 db 10,13,'3.Rangna                   100/-$'
    a24 db 10,13,'4.Peer-e-Kamil             100/-$'
    a25 db 10,13,'5.Mushaf                   100/-$'
    a26 db 10,13,'6.Namal                    100/-$'

    ; Islamic Books List (Price: 200)
    a27 db 10,13,'**************** Islamic Books List  ****************$'
    a28 db 10,13,'1.Minhaj-ul-Muslim         200/-$'
    a29 db 10,13,'2.Namaz-e-Nabvi            200/-$'
    a30 db 10,13,'3.Tib-e-Nabvi              200/-$'
    a31 db 10,13,'4.Ilimul-Muslim            200/-$'
    a32 db 10,13,'5.Tafseer Ahsan-ul-Bayan   200/-$'
    a33 db 10,13,'6.Riyad-us-Saliheen        200/-$'

.code
main proc
    ; Display Welcome Screen
    mov ah, 9
    mov dx, offset a1
    int 21h
    mov dx, offset a2
    int 21h
    mov dx, offset a3
    int 21h
    mov dx, offset a4
    int 21h
    mov dx, offset a5
    int 21h

    ; Main Prompt
    mov ah, 9
    mov dx, offset a19
    int 21h
    
    mov ah, 1
    int 21h
    sub al, 48

    cmp al, 1
    je BookList
    jmp Invalid

; ------------------------------------------------------
; SECTION: BOOK CATEGORY SELECTION
; ------------------------------------------------------
BookList:
    mov ah, 9
    mov dx, offset a7
    int 21h
    mov dx, offset a8
    int 21h

    mov ah, 1
    int 21h
    sub al, 48
    
    cmp al, 1
    je EnglishNovels
    cmp al, 2
    je UrduNovels
    cmp al, 3
    je IslamicBooks
    jmp Invalid

; ------------------------------------------------------
; SECTION: ENGLISH NOVELS (50/-)
; ------------------------------------------------------
EnglishNovels:
    mov ah, 9
    mov dx, offset a12
    int 21h
    mov dx, offset a13
    int 21h
    mov dx, offset a14
    int 21h
    mov dx, offset a15
    int 21h
    mov dx, offset a16
    int 21h
    mov dx, offset a17
    int 21h
    mov dx, offset a18
    int 21h

    mov ah, 9
    mov dx, offset a34
    int 21h
    
    mov ah, 1
    int 21h
    sub al, 48
    
    cmp al, 1
    jb Invalid
    cmp al, 6
    ja Invalid
    jmp Fifty

; ------------------------------------------------------
; SECTION: URDU NOVELS (100/-)
; ------------------------------------------------------
UrduNovels:
    mov ah, 9
    mov dx, offset a20
    int 21h
    mov dx, offset a21
    int 21h
    mov dx, offset a22
    int 21h
    mov dx, offset a23
    int 21h
    mov dx, offset a24
    int 21h
    mov dx, offset a25
    int 21h
    mov dx, offset a26
    int 21h

    mov ah, 9
    mov dx, offset a34
    int 21h
    
    mov ah, 1
    int 21h
    sub al, 48
    
    cmp al, 1
    jb Invalid
    cmp al, 6
    ja Invalid
    jmp Hundred

; ------------------------------------------------------
; SECTION: ISLAMIC BOOKS (200/-)
; ------------------------------------------------------
IslamicBooks:
    mov ah, 9
    mov dx, offset a27
    int 21h
    mov dx, offset a28
    int 21h
    mov dx, offset a29
    int 21h
    mov dx, offset a30
    int 21h
    mov dx, offset a31
    int 21h
    mov dx, offset a32
    int 21h
    mov dx, offset a33
    int 21h

    mov ah, 9
    mov dx, offset a34
    int 21h
    
    mov ah, 1
    int 21h
    sub al, 48
    
    cmp al, 1
    jb Invalid
    cmp al, 6
    ja Invalid
    jmp TwoHundred

; ------------------------------------------------------
; PRICE ASSIGNMENT
; ------------------------------------------------------
Fifty:
    mov bx, 50      
    jmp Calculate

Hundred:
    mov bx, 100
    jmp Calculate

TwoHundred:
    mov bx, 200

; ------------------------------------------------------
; CALCULATION AND OUTPUT
; ------------------------------------------------------
Calculate:
    mov ah, 9
    mov dx, offset a35
    int 21h
    
    mov ah, 1
    int 21h
    sub al, 48
    
    mov ah, 0       
    mul bx          

    push ax         

    mov ah, 9
    mov dx, offset a37
    int 21h

    pop ax         

    ; --- Multi-digit Display Logic ---
    mov cx, 0       
    mov bx, 10      

ConvertLoop:
    mov dx, 0       
    div bx          
    push dx         
    inc cx         
    cmp ax, 0       
    jne ConvertLoop

PrintDigits:
    pop dx          
    add dl, 30h    
    mov ah, 2
    int 21h         ; Print digit
    loop PrintDigits

    ; Post-Calculation Menu
    mov ah, 9
    mov dx, offset a38
    int 21h
    mov dx, offset a39
    int 21h
    
    mov ah, 1
    int 21h
    sub al, 48
    
    cmp al, 1
    je BookList
    cmp al, 2
    je Exit
    jmp Invalid

; ------------------------------------------------------
; PROGRAM TERMINATION
; ------------------------------------------------------
Invalid:
    mov ah, 9
    mov dx, offset a36
    int 21h
    jmp Exit

Exit:
    mov ah, 4Ch
    int 21h

main endp
end main