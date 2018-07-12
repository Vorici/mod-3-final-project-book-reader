require 'google/apis/drive_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'pry'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
APPLICATION_NAME = 'Drive API Ruby Quickstart'.freeze
CLIENT_SECRETS_PATH = 'client_secrets.json'.freeze
CREDENTIALS_PATH = 'token.yaml'.freeze
SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_METADATA_READONLY

##
# Ensure valid credentials, either by restoring from the saved credentials
# files or intitiating an OAuth2 authorization. If authorization is required,
# the user's default browser will be launched to approve the request.
#
# @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
def authorize
  client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
  token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
  authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
  user_id = 'default'
  credentials = authorizer.get_credentials(user_id)
  if credentials.nil?
    url = authorizer.get_authorization_url(base_url: OOB_URI)
    puts 'Open the following URL in the browser and enter the ' \
         "resulting code after authorization:\n" + url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI
    )
  end
  credentials
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# Book.create(title: "The Hitchhiker's Guide to the Galaxy", author: "Douglas Adams", content: "need bagels", user_id: 1)
# Book.create(title: "To Kill a Mockingbird", author: "Harper Lee", content: "need bagels", user_id: 1)
# Book.create(title: "Cloudy With a Chance of Meatballs", author: "Judi Barrett", content: "need bagels", user_id: 2)
# Book.create(title: "I Was Told There'd Be Cake", author: "Sloane Crosley", content: "need bagels", user_id: 2)
# Book.create(title: "One Hundred Years of Solitude", author: "Gabriel García Márquez", content: "need bagels", user_id: 2)
# Book.create(title: "The Hollow Chocolate Bunnies of the Apocalypse", author: "Robert Rankin", content: "need bagels", user_id: 1)
# Book.create(title: "Where the Wild Things Are", author: "Maurice Sendak", content: "need bagels", user_id: 2)
#
User.create(name: "Admin")
User.create(name: "Ledio")
User.create(name: "Greg")


books = [
  {book_num: '120844', image_count: 403, title: 'Software development: a rigorous approach', authors: 'Jones, Cliff B.', year: 1977, publisher: 'Prentice-Hall International, Inc., London', isbn: '0138218846', user_id: 2},
  {book_num: '120845', image_count: 593, title: 'Information systems: theory and practice', authors: 'Burch, John G. | Grudnitski, Gary | Strater, Felix R. | Hod, Nathan', year: 1985, publisher: 'John Wiley & Sons, Inc.', isbn: '0471123226', user_id: 1},
  {book_num: '120846', image_count: 521, title: 'Managing the software process', authors: 'Humphrey, Watts S.', year: 1989, publisher: 'Addison-Wesley Publishing Co. Inc.', isbn: '0201180952', user_id: 1},
  {book_num: '120847', image_count: 485, title: 'Digital computer fundamentals', authors: 'Bartee, Thomas C.', year: 1972, publisher: 'McGraw-Hill, Inc.', isbn: '070038910', user_id: 1},
  {book_num: '120848', image_count: 469, title: 'Microprocessor interfacing techniques', authors: 'Zaks, Rodnay/Lesea, A.', year: 1979, publisher: 'SYBEX, Inc.', isbn: '0895880296', user_id: 3},
  {book_num: '120849', image_count: 773, title: 'Numerical recipes in C: the art of scientific computing', authors: 'Press, William H. | Vetterling, William T. | Teukolsky, Saul A. 1947- | Flannery, Brian P.', year: 1988, publisher: 'Cambridge University Press', isbn: '052135465X', user_id: 1},
  {book_num: '120850', image_count: 311, title: 'Applying data structures', authors: 'Lewis, Theodore Gyle | Smith, Marilyn Z.', year: 1976, publisher: 'Houghton Mifflin Co.', isbn: '0395240603', user_id: 1},
  {book_num: '120852', image_count: 515, title: 'Systems programming', authors: 'Donovan, John J.', year: 1972, publisher: 'McGraw-Hill, Inc.', isbn: '070176035', user_id: 1},
  {book_num: '120853', image_count: 449, title: 'The Peter Norton Programmers guide to the IBM PC.', authors: 'Norton, Peter', year: 1985, publisher: 'Peter Norton', isbn: '0140871446', user_id: 1},
  {book_num: '120854', image_count: 515, title: 'PET-CBM personal computer guide', authors: 'Osborne, Adam | Donahue, Carroll S. | Commodore Business Machines, ', year: 1980, publisher: 'McGraw-Hill, Inc.', isbn: '0931988551', user_id: 1},
  {book_num: '120855', image_count: 453, title: 'Information processing', authors: 'Bohl, Marilyn | Science Research Associates, ', year: 1976, publisher: 'Science Research Associates, Inc.', isbn: '0574210407', user_id: 3},
  {book_num: '120856', image_count: 707, title: 'An introduction to operating systems', authors: 'Deitel, Harvey M.', year: 1984, publisher: 'Addison-Wesley Publishing Co., Inc.', isbn: '0201145014', user_id: 1},
  {book_num: '120857', image_count: 643, title: 'Programmers guide to the EGA and VGA cards', authors: 'Ferraro, Richard F.', year: 1988, publisher: 'Richard Ferraro', isbn: '0201126923', user_id: 1},
  {book_num: '120858', image_count: 643, title: 'PC-based voice processing: how to design, build and program voice processing systems using industry-standard Dialogic hardware', authors: 'Edgar, Bob', year: 1994, publisher: 'Bob Edgar', isbn: '0936648457', user_id: 1},
  {book_num: '120859', image_count: 383, title: 'Programming in PASCAL', authors: 'Grogono, Peter', year: 1980, publisher: 'Addison-Wesley Publishing Co., Inc.', isbn: '0201027755', user_id: 2},
  {book_num: '120860', image_count: 373, title: '8086/8088 16-bit microprocessor primer', authors: 'Morgan, Christopher L. / Waite, Mitchell', year: 1982, publisher: 'Christopher L. Morgan and Mitchell Waite', isbn: '0070431094', user_id: 1},
  {book_num: '120861', image_count: 453, title: 'Information processing', authors: 'Bohl, Marilyn', year: 1976, publisher: 'Science Research Associates, Inc.', isbn: '0574210407', user_id: 1},
  {book_num: '120862', image_count: 277, title: 'Data communications for microcomputers: with practical applications and experiments', authors: 'Nichols, Elizabeth Agnew | Musson, Keith R. | Nichols, Joseph C.,', year: 1982, publisher: 'McGraw-Hill, Inc.', isbn: '0070464804', user_id: 3},
  {book_num: '120863', image_count: 425, title: 'Digital computer electronics', authors: 'Malvino, Albert Paul', year: 1977, publisher: 'McGraw-Hill, Inc.', isbn: '0070398615', user_id: 1},
  {book_num: '120864', image_count: 247, title: 'Microcomputer operating systems', authors: 'Dahmke, Mark', year: 1982, publisher: 'BYTE Publications Inc.', isbn: '0070150710', user_id: 1},
  {book_num: '120865', image_count: 609, title: 'About face: the essentials of user interface design', authors: 'Cooper, Alan', year: 1995, publisher: 'IDG Books Worldwide, Inc.', isbn: '1568843224', user_id: 1},
  {book_num: '121340', image_count: 561, title: 'Building Internet firewalls', authors: 'Chapman, D. Brent | Zwicky, Elizabeth D.', year: 1995, publisher: 'OReilly & Associates, Inc.', isbn: '1565921240', user_id: 1},
  {book_num: '121341', image_count: 261, title: 'PostScript language tutorial and cookbook', authors: 'Adobe Systems, ', year: 1985, publisher: 'Adobe Systems Inc.', isbn: '0201101793', user_id: 2},
  {book_num: '121342', image_count: 245, title: 'PostScript language program design', authors: 'Reid, Glenn C.', year: 1988, publisher: 'Adobe Systems Inc.', isbn: '0201143968', user_id: 1},
  {book_num: '121343', image_count: 223, title: 'Securing Windows NT/2000 servers for the internet', authors: 'Norberg, Stefan', year: 2001, publisher: 'OReilly & Associates, Inc.', isbn: '1565927680', user_id: 1},
  {book_num: '121344', image_count: 435, title: 'Microsoft manual of style for technical publications', authors: 'Microsoft Corporation', year: 2004, publisher: 'Microsoft Corporation', isbn: '0735617465', user_id: 1},
  {book_num: '121345', image_count: 373, title: 'Optical publishing: a practical approach to developing CD ROM applications', authors: 'Ropiequet, Suzanne / Einberger, John / Zoellick, Bill', year: 1987, publisher: 'Microsoft Press', isbn: '1556150008', user_id: 1},
  {book_num: '121346', image_count: 527, title: 'Ethernet: the definitive guide', authors: 'Spurgeon, Charles E.', year: 2000, publisher: 'OReilly & Associates, Inc.', isbn: '1565926609', user_id: 1},
  {book_num: '121347', image_count: 445, title: 'TCP/IP clearly explained', authors: 'Loshin, Peter', year: 1997, publisher: 'Academic Press', isbn: '0124558356', user_id: 1},
  {book_num: '121348', image_count: 437, title: 'Microsoft exchange server: planning, design, and implementation', authors: 'Redmond, Tony, 1959-', year: 1997, publisher: 'Tony Redmond', isbn: '1555581625', user_id: 1},
  {book_num: '121349', image_count: 257, title: 'The Microsoft exchange server Internet mail connector', authors: 'Sakellariadis, Spyros Steven', year: 1997, publisher: 'DUKE Press', isbn: '188241960X', user_id: 2},
  {book_num: '121350', image_count: 715, title: 'Inside network perimeter security: the definitive guide to firewalls, VPNs, routers, and intrusion detection systems', authors: 'Northcutt, Stephen / Zeltser, Lenny / Winters, Scott', year: 2003, publisher: 'New Riders Publishing', isbn: '0735712328', user_id: 1},
  {book_num: '121351', image_count: 581, title: 'From chips to systems: an introduction to microprocessors', authors: 'Zaks, Rodnay', year: 1981, publisher: 'SYBEX Inc.', isbn: '0895880636', user_id: 1},
  {book_num: '121352', image_count: 245, title: 'Elements of Web design', authors: 'DiNucci, Darcy / Giudice, Maria / Stiles, Lynne', year: 1998, publisher: 'Darcy DiNucci, Maria Giudice and Lynne Stiles', isbn: '0201696983', user_id: 1},
  {book_num: '121353', image_count: 353, title: 'iAPX 88 Book', authors: 'Intel Corporation', year: 1981, publisher: 'Intel Corporation', isbn: '', user_id: 1},
  {book_num: '121362', image_count: 741, title: 'Microsoft windows for workgroups resource kit Version 3.1', authors: 'Microsoft', year: 1992, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121363', image_count: 467, title: 'Microsoft windows for workgroups resource kit addendum for operating system version 3.11', authors: 'Microsoft', year: 1993, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121364', image_count: 251, title: 'Getting it printed how to work with printers and graphic arts services to assure quality, stay on schedule and control costs', authors: 'Beach, Mark / Shepro, Steve / Russon, Ken', year: 1986, publisher: 'Coast to Coast Books', isbn: '', user_id: 1},
  {book_num: '121365', image_count: 213, title: 'How to photograph works of art', authors: 'Collins, Sheldan', year: 1992, publisher: 'Sheldan Confert Collins', isbn: '0817440194', user_id: 3},
  {book_num: '121366', image_count: 133, title: 'Getting started', authors: 'Tilling, Leslie', year: 1997, publisher: 'Equilibrium', isbn: '', user_id: 1},
  {book_num: '121367', image_count: 663, title: 'VB & VBA in a nutshell: the language', authors: 'Lomax, Paul', year: 1998, publisher: 'OReilly & Associates, Inc.', isbn: '1565923588', user_id: 1},
  {book_num: '121368', image_count: 155, title: 'IBM PS/Value Point Users Handbook', authors: 'International Business Machines Corporation', year: 1993, publisher: 'International Business Machines Corporation', isbn: '', user_id: 1},
  {book_num: '121369', image_count: 201, title: 'Microsoft workgroup add-on for windows users guide', authors: 'Microsoft', year: 1991, publisher: 'Microsoft Corporation PLC', isbn: '', user_id: 1},
  {book_num: '121370', image_count: 179, title: 'IBM Think pad 560X users guide', authors: 'IBM', year: 1997, publisher: 'International Business Machines Corporation', isbn: '', user_id: 1},
  {book_num: '121371', image_count: 243, title: 'MS-DOS users manual', authors: 'Microsoft', year: 1988, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121372', image_count: 183, title: 'Hewlett Packard users guide', authors: 'Hewlett Packard', year: 1995, publisher: 'Hewlett-Packard Company', isbn: '', user_id: 1},
  {book_num: '121373', image_count: 583, title: 'Microsoft Operating System 2', authors: 'Microsoft ', year: 1991, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121374', image_count: 125, title: 'Dell 486/L System users guide', authors: 'Dell', year: 1993, publisher: 'Dell Computer Corporation', isbn: '', user_id: 1},
  {book_num: '121375', image_count: 293, title: 'Microsoft MS-DOS6 plus enhanced tools', authors: 'Microsoft', year: 1993, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121376', image_count: 785, title: 'Microsoft SQL server for windows NT', authors: 'Microsoft', year: 1993, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121377', image_count: 471, title: 'Delphi for windows users guide', authors: 'Borland', year: 1995, publisher: 'Borland International', isbn: '', user_id: 1},
  {book_num: '121378', image_count: 213, title: 'Delphi for  windows database application developers guide', authors: 'Borland', year: 1995, publisher: 'Borland International', isbn: '', user_id: 1},
  {book_num: '121379', image_count: 251, title: 'Borland Paradox engine', authors: 'Borland', year: 1992, publisher: 'Borland International', isbn: '', user_id: 1},
  {book_num: '121380', image_count: 211, title: 'Paradox engine 2.0', authors: 'Borland', year: 1991, publisher: 'Borland International', isbn: '', user_id: 1},
  {book_num: '121381', image_count: 481, title: 'Microsoft MS-DOS3.3 users guide and reference', authors: 'Microsoft', year: 1988, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121382', image_count: 825, title: 'A discipline for software engineering', authors: 'Humphrey, Watts S.', year: 1995, publisher: 'Addison Wesley Longman, Inc.', isbn: '0201546108', user_id: 1},
  {book_num: '121383', image_count: 387, title: 'The data modeling handbook: a best-practice approach to building quality data models', authors: 'Reingruber, Michael C. | Gregory, William W.', year: 1994, publisher: 'John Wiley & Sons, Inc.', isbn: '0471052906', user_id: 1},
  {book_num: '121384', image_count: 1275, title: 'Computer graphics: principles and practice', authors: 'Hughes, John F. | Foley, James D.', year: 1990, publisher: 'Addison-Wesley Publishing Co., Inc.', isbn: '0201121107', user_id: 1},
  {book_num: '121385', image_count: 535, title: 'Microsoft secrets: how the worlds most powerful software company creates technology, shapes markets, and manages people', authors: 'Cusumano, Michael A. | Selby, Richard W.', year: 1995, publisher: 'Michael A. Cusumano and Richard W. Selby', isbn: '0028740483', user_id: 1},
  {book_num: '121386', image_count: 663, title: 'The art of computer programming: fundamental algorithms', authors: 'Knuth, Donald Ervin', year: 1973, publisher: 'Addison-Wesley Publishing Co., Inc.', isbn: '0201038099', user_id: 1},
  {book_num: '121387', image_count: 709, title: 'The art of computer programming: seminumerical algorithms', authors: 'Knuth, Donald Ervin', year: 1981, publisher: 'Addison-Wesley Publishing Co., Inc.', isbn: '0201038226', user_id: 1},
  {book_num: '121388', image_count: 745, title: 'The art of computer programming: sorting and searching', authors: 'Knuth, Donald Ervin', year: 1973, publisher: 'Addison-Wesley Publishing Co., Inc.', isbn: '020103803X', user_id: 1},
  {book_num: '121389', image_count: 377, title: 'Decline & fall of the American programmer', authors: 'Yourdon, Edward', year: 1992, publisher: 'Pretice-Hall, Inc.', isbn: '0132036703', user_id: 1},
  {book_num: '121390', image_count: 419, title: 'An introduction to object-oriented programming', authors: 'Budd, Timothy', year: 1991, publisher: 'Addison-Wesley Publishing Co., Inc.', isbn: '0201547090', user_id: 1},
  {book_num: '121391', image_count: 419, title: 'PC DOS6.3 command reference and error messages', authors: 'IBM', year: 1994, publisher: 'International Business Machines Corporation', isbn: '', user_id: 1},
  {book_num: '121392', image_count: 675, title: 'Microsoft MS-DOS: users guide, users reference and shell users guide', authors: 'Microsoft', year: 1988, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121393', image_count: 287, title: 'Microsoft MS-DOS plus enhanced tools users guide', authors: 'Microsoft', year: 1994, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121394', image_count: 675, title: 'Microsoft windows: graphical enviroment users guide', authors: 'Microsoft', year: 1990, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121395', image_count: 653, title: 'Microsoft windows NT server: system guide', authors: 'Microsoft', year: 1994, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121396', image_count: 151, title: 'Microsoft OS/2: command reference', authors: 'Microsoft', year: 1991, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121397', image_count: 325, title: 'Microsoft windows: users guide', authors: 'Microsoft', year: 1993, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121398', image_count: 133, title: 'PC DOS6.3: data compression guide', authors: 'IBM', year: 1994, publisher: 'International Business Machines Corporation', isbn: '', user_id: 1},
  {book_num: '121399', image_count: 477, title: 'PC DOS6.3: Users guide', authors: 'IBM', year: 1994, publisher: 'International Business Machines Corporation', isbn: '', user_id: 1},
  {book_num: '121400', image_count: 235, title: 'Microsoft windows NT server: installation guide', authors: 'IBM', year: 1994, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121401', image_count: 453, title: 'Microsoft windows and MS-DOS6.2: users guide', authors: 'Microsoft', year: 1993, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121402', image_count: 657, title: 'Microsoft windows for workgroups and MS-DOS ', authors: 'Microsoft', year: 1994, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121403', image_count: 423, title: 'Microsoft GW-BASIC: users guide and users reference', authors: 'Microsoft', year: 1987, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121454', image_count: 191, title: 'Paradox engine: Pascal reference guide', authors: 'Borland', year: 1990, publisher: 'Borland International', isbn: '', user_id: 1},
  {book_num: '121455', image_count: 113, title: 'Paradox engine: users guide', authors: 'Borland', year: 1990, publisher: 'Borland International', isbn: '', user_id: 1},
  {book_num: '121484', image_count: 329, title: 'Show-stopper!: the breakneck race to create Windows NT and the next generation at Microsoft', authors: 'Zachary, G. Pascal', year: 1994, publisher: 'G. Pascal Zachary', isbn: '0029356717', user_id: 1},
  {book_num: '121485', image_count: 483, title: 'Microsoft MS/DOS: users guide and users reference V3.3', authors: 'Microsoft', year: 1987, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121486', image_count: 287, title: 'Microsoft MS-DOS6.22: users guide', authors: 'Microsoft', year: 1994, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121487', image_count: 335, title: 'ThinkPad 760E / 160ED / 760EL', authors: 'IBM', year: 1996, publisher: 'International Business Machines Corporation', isbn: '', user_id: 1},
  {book_num: '121488', image_count: 353, title: 'Microsoft MS-DOS 6 users guide: Take a road trip with the MS-DOS 6 upgrade', authors: 'Microsoft', year: 1993, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121489', image_count: 629, title: 'NetWare C Interdface - DOS: Professional development series', authors: 'Novell', year: 1990, publisher: 'Novell, Inc.', isbn: '', user_id: 1},
  {book_num: '121490', image_count: 653, title: 'NetWare C Interface - DOS: Professiona development  series Vol 1', authors: 'Novell', year: 1990, publisher: 'Novell, Inc.', isbn: '', user_id: 1},
  {book_num: '121491', image_count: 689, title: 'Microsoft MS-DOS: users guide and reference, Version 5.0', authors: 'Microsoft', year: 1991, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121492', image_count: 309, title: 'Inside OS/2', authors: 'Letwin, Gordon', year: 1988, publisher: 'Microsoft Press', isbn: '1556151179', user_id: 1},
  {book_num: '121493', image_count: 633, title: 'Microsoft: Getting results with Microsoft Office for windows 95', authors: 'Microsoft', year: 1996, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121494', image_count: 389, title: 'Literate programming', authors: 'Knuth, Donald Ervin', year: 1992, publisher: 'Center for the Study of Language and Information', isbn: '0937073806', user_id: 1},
  {book_num: '121495', image_count: 247, title: 'InterBase: Language reference', authors: 'Borland', year: 1995, publisher: 'Borland International', isbn: '', user_id: 1},
  {book_num: '121496', image_count: 643, title: 'The New papyrus: the current and future state of the art', authors: 'Lambert, Steve', year: 1986, publisher: 'Microsoft Press', isbn: '0914845748', user_id: 1},
  {book_num: '121497', image_count: 379, title: 'Running MS-DOS: the Microsoft guide to getting the most out of the standard operating system for the IBM PC and 50 other personal computers', authors: 'Wolverton, Van', year: 1984, publisher: 'Van Wolverton', isbn: '0671308394', user_id: 1},
  {book_num: '121498', image_count: 325, title: 'Ulead Photolmpact 12: Professional image editing made easy', authors: 'Ulead ', year: 2006, publisher: 'Ulead System, Inc.', isbn: '', user_id: 1},
  {book_num: '121499', image_count: 337, title: 'PostScript language reference manual', authors: 'Adobe Systems Incorporated', year: 1985, publisher: 'Addison-Wesley Publishing Co.', isbn: '0201101742', user_id: 1},
  {book_num: '121500', image_count: 275, title: '6502 software design', authors: 'Scanlon, Leo J.', year: 1980, publisher: 'Leo J. Scanlon', isbn: '0672216566', user_id: 1},
  {book_num: '121501', image_count: 421, title: 'How to program and interface the 6800', authors: 'Staugaard Jr., Andrew C.', year: 1980, publisher: 'Andrew C. Staugaard Jr.', isbn: '0672216841', user_id: 1},
  {book_num: '121502', image_count: 761, title: 'Database management', authors: 'McFadden, Fred R. | Hoffer, Jeffrey A.', year: 1991, publisher: 'The Benjamin Cummings Publishing Co., Inc.', isbn: '0805360409', user_id: 1},
  {book_num: '121503', image_count: 357, title: 'Business data systems: a practical guide to systems analysis and data processing', authors: 'Clifton, Harold Dennis', year: 1978, publisher: 'The Prentice-Hall International, Inc.', isbn: '0130939633', user_id: 1},
  {book_num: '121504', image_count: 615, title: 'Object oriented design with applications', authors: 'Booch, Grady', year: 1991, publisher: 'The Benjamin/Cummings Publishing Co., Inc.', isbn: '0805300910', user_id: 1},
  {book_num: '121505', image_count: 139, title: 'Delphi: World tour, Main Event and Delphi Extended', authors: 'Borland', year: 1995, publisher: 'Softbite International, Ltd.', isbn: '', user_id: 1},
  {book_num: '121506', image_count: 533, title: 'Netfinity 5500: users handbook', authors: 'IBM', year: 1998, publisher: 'International Business Machines Corporation', isbn: '', user_id: 1},
  {book_num: '121507', image_count: 319, title: 'C-Scape Version 4 manual', authors: 'Liant', year: 1992, publisher: 'Liant Software Corporation', isbn: '', user_id: 1},
  {book_num: '121508', image_count: 245, title: 'Precision Workstation 410 Mini Tower Systems: users guide', authors: 'DELL', year: 1998, publisher: 'DELL Computer Corporation', isbn: '', user_id: 1},
  {book_num: '121509', image_count: 123, title: 'Windows 95', authors: 'Microsoft', year: 1996, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121510', image_count: 579, title: 'OS/2: Using the Operating System', authors: 'IBM', year: 1993, publisher: 'International Business Machines Corporation', isbn: '', user_id: 1},
  {book_num: '121511', image_count: 209, title: 'OS/2: Installation guide', authors: 'IBM', year: 1993, publisher: 'International Business Machines Corporation', isbn: '', user_id: 1},
  {book_num: '121512', image_count: 681, title: 'Microsoft Windows: Users guide', authors: 'Microsoft', year: 1992, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121513', image_count: 545, title: 'Microsoft Windows NT: Workstation', authors: 'Microsoft', year: 1994, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121514', image_count: 125, title: 'Introduction Microsoft Windows95', authors: 'Microsoft ', year: 1995, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121515', image_count: 633, title: 'Getting results with Microsoft Office for Windows 95: Real world solutions for the work you do', authors: 'Microsoft ', year: 1995, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121516', image_count: 163, title: 'Microsoft Windows 98: Getting started ', authors: 'Microsoft', year: 1998, publisher: 'Microsoft Corporation', isbn: '', user_id: 1},
  {book_num: '121517', image_count: 217, title: 'Value point, Innstalling Options, Models 6472, 6482 and 6484', authors: 'IBM', year: 1994, publisher: 'International Business Machines Corporation', isbn: '', user_id: 1},
  {book_num: '120782', image_count: 483, title: 'Butlers Lives of the Saints', authors: 'Rev. Alban Butler', year: 1868, publisher: 'James Duffy', isbn: '', user_id: 1},
  {book_num: '120792', image_count: 155, title: 'Select Letters of Cicero', authors: 'Rev. G. E. Jeans, M.A.', year: 1898, publisher: 'The Macmillan Co.', isbn: '', user_id: 1},
  {book_num: '121531', image_count: 99, title: 'Anecdotes Faciles et Poésies', authors: 'Super, O. B.', year: 1905, publisher: 'D. C. Heath and Co. ', isbn: '', user_id: 1},
  {book_num: '121532', image_count: 293, title: 'A Latin Grammar', authors: 'Bennett, Charles E.', year: 1908, publisher: 'Charles E. Bennett', isbn: '', user_id: 1},
  {book_num: '121552', image_count: 396, title: 'Complete Poems of  Francis Thompson', authors: 'Thompson, Francis', year: 1913, publisher: 'Random House', isbn: '', user_id: 1},
  {book_num: '121458', image_count: 737, title: 'The College Chaucer', authors: 'MacCracken, Henry Noble', year: 1913, publisher: 'Yale University Press', isbn: '', user_id: 1},
  {book_num: '121554', image_count: 459, title: 'Selections and Essays ', authors: 'Ruskin, John', year: 1918, publisher: 'Charles Scribners Sons', isbn: '', user_id: 1},
  {book_num: '120797', image_count: 145, title: 'Laelius De Amicitia', authors: 'Charles E. Bennett', year: 1920, publisher: 'Norwood Press', isbn: '', user_id: 1},
  {book_num: '120801', image_count: 177, title: 'Herodotus Book VII ', authors: 'C. E. Robinson', year: 1922, publisher: 'Clarendon Press', isbn: '', user_id: 1},
  {book_num: '121555', image_count: 539, title: 'American Poetry', authors: 'De Mille, A. B. ', year: 1923, publisher: 'Allyn and Bacon', isbn: '', user_id: 1},
  {book_num: '121786', image_count: 901, title: 'The Customs of Mankind', authors: 'Eichler, Lillian', year: 1924, publisher: 'Doubleday, Page and Co.', isbn: '', user_id: 1},
  {book_num: '121583', image_count: 305, title: 'Heidi', authors: 'Spyri, Johnanna', year: 1924, publisher: 'The John C. Winston Co.', isbn: '', user_id: 1},
  {book_num: '121584', image_count: 285, title: 'The Arabian Nights', authors: 'Lowe, Orton', year: 1924, publisher: 'The John C. Winston Co.', isbn: '', user_id: 1},
  {book_num: '121586', image_count: 343, title: 'Tales from Shakespeare', authors: 'Lamb, Charles and Mary', year: 1924, publisher: 'The John C. Winston Co.', isbn: '', user_id: 1},
  {book_num: '121585', image_count: 365, title: 'Kidnapped', authors: 'Stevenson, Robert Louis', year: 1925, publisher: 'The John C. Winston Co.', isbn: '', user_id: 1},
  {book_num: '121587', image_count: 325, title: 'Robinson Crusoe', authors: 'DeFoe, Daniel', year: 1925, publisher: 'The John C. Winston Co.', isbn: '', user_id: 1},
  {book_num: '121464', image_count: 761, title: 'English  Literature: A survey and a Commentary', authors: 'Brother Leo', year: 1928, publisher: 'Ginn and Co.', isbn: '', user_id: 1},
  {book_num: '120789', image_count: 33, title: 'Primitive Man Quarterly Bulletin of the Catholic Anthropological Conference', authors: 'Rev. John M. Cooper', year: 1929, publisher: '', isbn: '', user_id: 1},
  {book_num: '121551', image_count: 515, title: 'A History of English Literature', authors: 'Neilson, William Allan / Thorndike, Ashley Horace', year: 1930, publisher: 'The Macmillan Co.', isbn: '', user_id: 1},
  {book_num: '121709', image_count: 93, title: 'Souvenir of the Diamond Jubilee of Saint Marys Parish', authors: '', year: 1930, publisher: '', isbn: '', user_id: 1},
  {book_num: '121481', image_count: 233, title: 'The Vanishing Shadow', authors: 'Sutton, Margaret', year: 1932, publisher: 'Grosset and Dunlap, Inc.', isbn: '', user_id: 1},
  {book_num: '121706', image_count: 439, title: 'The Story of Philosophy ', authors: 'Durant, Will', year: 1933, publisher: 'Will Durant', isbn: '', user_id: 1},
  {book_num: '121478', image_count: 749, title: 'Adventures in Appreciation', authors: 'Cook, Luella B. / Loban, Walter / Baxter, Susanna', year: 1936, publisher: 'Harcourt, Brace and Co., Inc.', isbn: '', user_id: 1},
  {book_num: '121546', image_count: 407, title: 'The Science of Correct Thinking ', authors: 'Bittle, Celestine N.', year: 1937, publisher: 'The Bruce Publishing Co.', isbn: '', user_id: 1},
  {book_num: '121547', image_count: 765, title: 'The Federal Union', authors: 'Hicks, John D.', year: 1937, publisher: 'John D. Hicks', isbn: '', user_id: 1},
  {book_num: '121548', image_count: 797, title: 'The Great Critics', authors: 'Smith, James Harry / Parks, Edd Winfield', year: 1939, publisher: 'W. W. Norton and Co., Inc.', isbn: '', user_id: 1},
  {book_num: '121566', image_count: 259, title: 'Our Country Begins', authors: 'Furlong, Philip J. / Ganey, Helen M. / Downing, Francis ', year: 1939, publisher: 'W. H. Sadlier, Inc.', isbn: '', user_id: 1},
  {book_num: '120803', image_count: 147, title: 'Cato Maior De Senectute', authors: 'Charles E. Bennett', year: 1940, publisher: 'Benj. H. Sanborn & Co.', isbn: '', user_id: 1},
  {book_num: '121482', image_count: 189, title: 'The Man who got even with God: The life of an American Trappist', authors: 'Raymond, M.', year: 1941, publisher: 'The Bruce Publishing Co.', isbn: '', user_id: 1},
  {book_num: '121702', image_count: 1047, title: 'The Great Historians', authors: 'Godolphin, Francis R. B.', year: 1942, publisher: 'Random House, Inc.', isbn: '', user_id: 1},
  {book_num: '121703', image_count: 979, title: 'The Greek Historians', authors: 'Godolphin, Francis R. B.', year: 1942, publisher: 'Random House, Inc.', isbn: '', user_id: 1},
  {book_num: '121707', image_count: 1184, title: 'The College Survey of English Literature', authors: 'Whiting, B. J.', year: 1942, publisher: 'Harcourt, Brace and Co., Inc.', isbn: '', user_id: 1},
  {book_num: '121708', image_count: 1211, title: 'The College Survey of  English Literature', authors: 'Whiting, B. J.', year: 1942, publisher: 'Harcourt, Brace and Co., Inc.', isbn: '', user_id: 1},
  {book_num: '121535', image_count: 147, title: 'Blitz French: A handbook of Action French for the fighting forces', authors: 'Nicot, Georges', year: 1943, publisher: 'Military Service Publishing Co.', isbn: '', user_id: 1},
  {book_num: '121466', image_count: 589, title: 'The New Testament of  our Lord and Saviour Jesus Christ', authors: 'Knox, R. A.', year: 1944, publisher: 'Sheed and Ward, Inc.', isbn: '', user_id: 1},
  {book_num: '121537', image_count: 309, title: 'Johnny Tremain', authors: 'Forbes, Esther', year: 1945, publisher: 'Houghton Mifflin Co.', isbn: '', user_id: 1},
  {book_num: '120790', image_count: 45, title: 'A Little Book of Somerset County Verse', authors: '', year: 1945, publisher: 'Sesquicentennial Publications ', isbn: '', user_id: 1},
  {book_num: '121545', image_count: 803, title: 'Ulysses', authors: 'Joyce, James', year: 1946, publisher: 'Nora Joseph Joyce', isbn: '', user_id: 1},
  {book_num: '120798', image_count: 463, title: 'An Introduction to Greek', authors: 'Henry Lamar Crosby / John Nevin Schaeffer', year: 1947, publisher: 'Allyn and Bacon', isbn: '', user_id: 1},
  {book_num: '121699', image_count: 1638, title: 'American Poetry and Prose', authors: 'Foerster, Norman', year: 1947, publisher: 'Norman Foerster', isbn: '', user_id: 1},
  {book_num: '121457', image_count: 261, title: 'Emily Dickinson Poems', authors: 'Emily Dickinson', year: 1948, publisher: 'The World Publishing Co.', isbn: '', user_id: 1},
  {book_num: '121570', image_count: 321, title: 'The Greatest Story Ever Told', authors: 'Oursler, Fulton', year: 1949, publisher: 'Fulton Oursler', isbn: '', user_id: 1},
  {book_num: '121462', image_count: 629, title: 'Man as Man: the science and art of Ethics', authors: 'Higgins, Rev. Thomas J.', year: 1949, publisher: 'The Bruce Publishing Co.', isbn: '', user_id: 1},
  {book_num: '121483', image_count: 803, title: 'The Critical Reader', authors: 'Douglas, Wallace W. / Lamson, Roy and Hallet', year: 1949, publisher: 'W. W. Norton', isbn: '', user_id: 1},
  {book_num: '121553', image_count: 438, title: 'Alexander Pope Selected Woks', authors: 'Kronenberger, Louis', year: 1951, publisher: 'Random House Inc.', isbn: '', user_id: 1},
  {book_num: '120793', image_count: 73, title: 'The Latin Lyric of the Golden Middle Age', authors: '', year: 1951, publisher: 'Seton Hill College', isbn: '', user_id: 1},
  {book_num: '121534', image_count: 157, title: 'The Salt Lick ', authors: 'Class of 1952', year: 1952, publisher: '', isbn: '', user_id: 1},
  {book_num: '121701', image_count: 1129, title: 'A College Book of American Literature', authors: 'Clark, Harry Hayden', year: 1954, publisher: 'American Book Co.', isbn: '', user_id: 1},
  {book_num: '121536', image_count: 255, title: 'Victory Drums', authors: 'Betz, Eva K.', year: 1955, publisher: 'Eva K. Betz', isbn: '', user_id: 1},
  {book_num: '121594', image_count: 1385, title: 'The American Tradition in Literature', authors: 'Bradley, Sculley / Beatty, Richmond Croom / Long, E. Hudson', year: 1956, publisher: 'W. W. Norton and Co., Inc.', isbn: '', user_id: 1},
  {book_num: '121550', image_count: 707, title: 'The complete short stories of Mark Twain now collected for the first time.', authors: 'Neider, Charles', year: 1957, publisher: 'Charles Neider', isbn: '038501502X', user_id: 1},
  {book_num: '121518', image_count: 59, title: 'Metropolitan Seminars In Art: Portfolio 1, What is a Painting?', authors: 'Canaday, John ', year: 1958, publisher: 'John Canaday', isbn: '', user_id: 1},
  {book_num: '121519', image_count: 49, title: 'Metropolitan Seminars In Art: Portofolio 2, Realism', authors: 'Canaday, John', year: 1958, publisher: 'John Canaday', isbn: '', user_id: 1},
  {book_num: '121520', image_count: 51, title: 'Metropolitan Seminars In Art: Portofolio 3, Expressionism', authors: 'Canaday, John', year: 1958, publisher: 'The Metropolitan Museum of Art', isbn: '', user_id: 1},
  {book_num: '121521', image_count: 53, title: 'Metropolitan Seminars In Art: Portfolio 4, Abstraction', authors: 'Canaday, John', year: 1958, publisher: 'The Metropolitan Museum of Art', isbn: '', user_id: 1},
  {book_num: '121522', image_count: 51, title: 'Metropolitan Seminars In Art: Portifolio 5, Composition', authors: 'Canaday, John', year: 1958, publisher: 'The Metropolitan Museum of Art', isbn: '', user_id: 1},
  {book_num: '121523', image_count: 47, title: 'Metropolitan Seminars In Art: Portfolio 6, Composition', authors: 'Canaday, John', year: 1958, publisher: 'The Metropolitan Museum of Art', isbn: '', user_id: 1},
  {book_num: '121524', image_count: 52, title: 'Metropolitan Seminars In Art: Portfolio 7 Composition as Expression', authors: 'Canaday, John', year: 1958, publisher: 'The Metropolitan Museum of Art', isbn: '', user_id: 1},
  {book_num: '121525', image_count: 50, title: 'Metropolitan Seminars In Art: Portfolio 8, Techniques', authors: 'Canaday, John', year: 1958, publisher: 'The Metropolitan Museum of Art', isbn: '', user_id: 1},
  {book_num: '121526', image_count: 61, title: 'Metropolitan Seminars In Art: Portfolio 9, Techniques ', authors: 'Canaday, John', year: 1958, publisher: 'The Metropolitan Museum of Art', isbn: '', user_id: 1},
  {book_num: '121527', image_count: 49, title: 'Metropolitan Seminars In Art: Portfolio 10, Techniques', authors: 'Canaday, John', year: 1958, publisher: 'The Metropolitan Museum of Art', isbn: '', user_id: 1},
  {book_num: '121538', image_count: 865, title: 'The Odyssey: A modern sequel ', authors: 'Kazantzakis, Nikos', year: 1958, publisher: 'Simon and Schuster, Inc.', isbn: '', user_id: 1},
  {book_num: '121528', image_count: 50, title: 'Metropolitan Seminars In Art: Portfolio 11, The Artist', authors: 'Canaday, John', year: 1958, publisher: 'The Metropolitan Museum of Art', isbn: '', user_id: 1},
  {book_num: '121456', image_count: 773, title: 'Lives of the Poets', authors: 'Untermeyer, Louis', year: 1959, publisher: 'Simon and Schuster', isbn: '', user_id: 1},
  {book_num: '121787', image_count: 505, title: 'The Grammar and Composition', authors: 'Warriner, John E.', year: 1959, publisher: 'Harcourt, Brace and Co., Inc.', isbn: '', user_id: 1},
  {book_num: '121539', image_count: 1561, title: 'Dictionnaire Moderne: Français - Anglais', authors: 'Dubois, Marguerite-Marie', year: 1960, publisher: 'Augé, Gillon, Hollier-Larousse, Moreau et Cie.', isbn: '', user_id: 1},
  {book_num: '121593', image_count: 567, title: 'A Library of Literary Criticism', authors: 'Nyren, Dorothy', year: 1960, publisher: 'Frederick Ungar Publishing Co.', isbn: '', user_id: 1},
  {book_num: '121705', image_count: 325, title: 'Times Three', authors: 'McGinley, Phyllis', year: 1960, publisher: 'Phyllis McGinley', isbn: '', user_id: 1},
  {book_num: '121791', image_count: 567, title: '100 great operas and their stories', authors: 'Simon, Henry W.', year: 1960, publisher: 'Doubleday', isbn: '0385054483', user_id: 1},
  {book_num: '120794', image_count: 947, title: 'The Classic Latin Dictionary', authors: '', year: 1961, publisher: 'Follett Publishing Company', isbn: '', user_id: 1},
  {book_num: '121760', image_count: 449, title: 'Using Latin', authors: 'Horn, Annabel / Gummere, John Flagg / Forbes, Margaret M.', year: 1961, publisher: 'Scott, Foresman and Co.', isbn: '', user_id: 1},
  {book_num: '121761', image_count: 349, title: 'Nichomachean Ethics', authors: 'Ostwald, Martin', year: 1962, publisher: 'The Liberal Arts Press, Inc.', isbn: '0672602563', user_id: 1},
  {book_num: '121564', image_count: 1541, title: 'Literary History of the United States', authors: 'Spiller, Robert E. / Thorp, Willard / Johnson, Thomas H.', year: 1963, publisher: 'The Macmillan Co.', isbn: '', user_id: 1},
  {book_num: '121788', image_count: 451, title: 'Childhood and Society', authors: 'Erickson, Erik H.', year: 1963, publisher: 'W. W. Norton and Co., Inc.', isbn: '', user_id: 1},
  {book_num: '121474', image_count: 805, title: 'Report of the Warren Commission: The assassination of President Kennedy', authors: 'The New York Times ', year: 1964, publisher: 'The New York Times Co.', isbn: '', user_id: 1},
  {book_num: '121477', image_count: 393, title: 'History of the  World', authors: 'Gelinas, Paul J.', year: 1965, publisher: 'Grosset and Dunlap, Inc.', isbn: '', user_id: 1},
  {book_num: '121561', image_count: 741, title: 'Larousse Encyclopedia of World Geography', authors: 'Deffontaines, Pierre', year: 1965, publisher: 'Western Publishing Co.', isbn: '', user_id: 1},
  {book_num: '121588', image_count: 455, title: 'Winston Churchill An Intimate Portrait', authors: 'Carter, Violet Bonham', year: 1965, publisher: 'Violet Bonham Carter', isbn: '', user_id: 1},
  {book_num: '121759', image_count: 499, title: 'Story of Language', authors: 'Pei, Mario', year: 1965, publisher: 'Mario Pei', isbn: '', user_id: 1},
  {book_num: '121790', image_count: 495, title: 'Roman drama.', authors: 'Copley, Frank O. / Hades, Moses', year: 1965, publisher: 'The Bobbs Merrill Co., Inc.', isbn: '0672604558', user_id: 1},
  {book_num: '121842', image_count: 322, title: 'The New Yorker:  Album Fortieth Annirvesary', authors: '', year: 1965, publisher: 'The New Yorker Magizene, Inc.', isbn: '', user_id: 1},
  {book_num: '121764', image_count: 95, title: 'For Ccist Luve: Prayers of Saint Aelred Abbot of Rievaulx', authors: 'Hoste, D. Anselm', year: 1965, publisher: '', isbn: '', user_id: 1},
  {book_num: '121562', image_count: 177, title: 'The Stars A new way to see them', authors: 'Rey, H. A.', year: 1966, publisher: 'H. A. Rey', isbn: '', user_id: 1},
  {book_num: '121568', image_count: 621, title: 'Living Latin: A Contemporary Approach', authors: 'Ashley, Clara W. / Lashbrook, Austin M.', year: 1967, publisher: 'Ginn and Co.', isbn: '', user_id: 1},
  {book_num: '121590', image_count: 1193, title: 'Rousseau and Revolution', authors: 'Durant, Will and Ariel', year: 1967, publisher: 'Will and Ariel Durant', isbn: '', user_id: 1},
  {book_num: '121596', image_count: 377, title: 'Incredible Victory', authors: 'Lord, Walter', year: 1967, publisher: 'Walter Lord', isbn: '', user_id: 1},
  {book_num: '121569', image_count: 905, title: 'American Literature', authors: 'Schorer, Mark / Jewett, Arno / Havighurst, Walter / Kirschner, Alllen', year: 1968, publisher: 'Houghton Mifflin Co.', isbn: '', user_id: 1},
  {book_num: '121592', image_count: 841, title: 'England in Literature', authors: 'Pooley, Robert C.', year: 1968, publisher: 'Scott, Foresman and Co.', isbn: '', user_id: 1},
  {book_num: '121549', image_count: 551, title: 'From Stars to Sculptures', authors: 'Shepherd, David L. / Ragger, Rita A. / Schaefer, Wilbert S.', year: 1969, publisher: 'Harper and Row, Publishers, Inc.', isbn: '', user_id: 1},
  {book_num: '121567', image_count: 191, title: 'The Peter Principle', authors: 'Peter, Laurence F. / Hull, Raymond', year: 1969, publisher: 'William Morrow and Co., Inc.', isbn: '', user_id: 1},
  {book_num: '121591', image_count: 1105, title: 'A Long Row of Candles', authors: 'Sulzberger, C. L. ', year: 1969, publisher: 'C. L. Sulzberger', isbn: '', user_id: 1},
  {book_num: '121700', image_count: 553, title: 'The Great Ideas  Today', authors: 'Hutchins, Robert M. / Adler, Mortimer J.', year: 1969, publisher: 'Encyclopedia Britannica, Inc.', isbn: '', user_id: 1},
  {book_num: '121463', image_count: 451, title: 'Losing Battles', authors: 'Welty, Eudora', year: 1970, publisher: 'Eudora Welty', isbn: '', user_id: 1},
  {book_num: '121479', image_count: 763, title: 'Roosevelt: the soldier of freedom.', authors: 'Burns, James MacGregor', year: 1970, publisher: 'James MacGregor Burns', isbn: '0151788715', user_id: 1},
  {book_num: '121563', image_count: 269, title: 'The dream king: Ludwig II of Bavaria', authors: 'Blunt, Wilfred / Petzet, Michael', year: 1970, publisher: 'Wilfred Blunt', isbn: '0140036067', user_id: 1},
  {book_num: '121571', image_count: 1199, title: 'Brewers Dictionary of Phrase and Fable', authors: 'Evans, Ivor H. ', year: 1970, publisher: 'Cassell and Co., Ltd.', isbn: '', user_id: 1},
  {book_num: '121704', image_count: 581, title: 'Man in Literature', authors: 'Kneer, Leo B.', year: 1970, publisher: 'Scott, Foresman and Co.', isbn: '', user_id: 1},
  {book_num: '121848', image_count: 408, title: 'Translations from the French', authors: 'Miller Jr., James E. / ONeal, Robert, / McDonnell, Hellen M.', year: 1970, publisher: 'Scott, Foresman and Co.', isbn: '', user_id: 1},
  {book_num: '121533', image_count: 69, title: 'Switzerland in pictures', authors: 'Masters, Robert V.', year: 1970, publisher: 'Sterling Publishing Co., Inc.', isbn: '080691016X', user_id: 1},
  {book_num: '121472', image_count: 261, title: 'The Knew The Unknown', authors: 'Ebon, Martin', year: 1971, publisher: 'Lombard Associates', isbn: '', user_id: 1},
  {book_num: '121589', image_count: 537, title: 'The Name Above The Title', authors: 'Capra, Frank', year: 1971, publisher: 'Frank Capra', isbn: '', user_id: 1},
  {book_num: '121598', image_count: 107, title: 'The little prince', authors: 'De Saint-Exupéry, Antoine', year: 1971, publisher: 'Harcourt Brace Jovanovich, Inc.', isbn: '0152465030', user_id: 1},
  {book_num: '121763', image_count: 25, title: 'Lively Latin', authors: 'Colby, John K.', year: 1971, publisher: 'Independent School Press, Inc.', isbn: '', user_id: 1},
  {book_num: '121844', image_count: 354, title: 'Leaders of American: Elementary and Secondary Education', authors: '', year: 1971, publisher: '', isbn: '', user_id: 1},
  {book_num: '121843', image_count: 76, title: 'The Swing Era: How it was to be young', authors: 'Daniels, George G.', year: 1972, publisher: 'Time Inc.', isbn: '', user_id: 1},
  {book_num: '121467', image_count: 649, title: 'American Government', authors: 'Smith, Mary Magrudder', year: 1973, publisher: ' Mary Magrudder Smith', isbn: '', user_id: 1},
  {book_num: '121473', image_count: 935, title: 'Centennial', authors: 'Michener, James A.', year: 1974, publisher: 'Random House, Inc.', isbn: '', user_id: 1},
  {book_num: '121846', image_count: 494, title: 'Applied finite mathematics', authors: 'Anton, Howard | Kolman, Bernard', year: 1975, publisher: 'Academic Press, Inc.', isbn: '0120595508', user_id: 1},
  {book_num: '121476', image_count: 745, title: 'Reflections in Literature', authors: 'McFarland, Philip James | Breakstone, Sharon | Peckham, Morse', year: 1975, publisher: 'Houghton Mifflin Co.', isbn: '0395200733', user_id: 1},
  {book_num: '121470', image_count: 439, title: 'Blind ambition: the White House years', authors: 'Dean, John Wesley', year: 1976, publisher: 'John W. Dean', isbn: '0671224387', user_id: 1},
  {book_num: '121560', image_count: 357, title: 'The History of furniture', authors: 'Battersby, Martin / Beard, Geoffrey / Bennett, Ian', year: 1976, publisher: 'Orbis Publishing Ltd.', isbn: '0688030831', user_id: 1},
  {book_num: '121845', image_count: 748, title: 'On war', authors: 'Howard, Michael, | Paret, Peter', year: 1976, publisher: 'Princeton University Press', isbn: '0691018545', user_id: 1},
  {book_num: '121469', image_count: 611, title: 'The Matarese circle', authors: 'Ludlum, Robert', year: 1979, publisher: 'Robert Ludlum', isbn: '0399900438', user_id: 1},
  {book_num: '121558', image_count: 249, title: 'Degas', authors: 'Dunlop, Ian', year: 1979, publisher: 'John Calmann and Cooper Ltd.', isbn: '006111119', user_id: 1},
  {book_num: '121834', image_count: 239, title: 'Office politics: seizing power, wielding clout', authors: 'Kennedy, Marilyn Moats, 1943-', year: 1980, publisher: 'Karen  Yops', isbn: '0695813064', user_id: 1},
  {book_num: '121841', image_count: 268, title: 'The implementation of project management: the professionals handbook', authors: 'Stuckenbruck, Linn C.', year: 1981, publisher: 'Addison-Wesley Publishing Co., Inc', isbn: '0201072602', user_id: 1},
  {book_num: '121829', image_count: 332, title: 'The Kennedy imprisonment: a meditation on power', authors: 'Wills, Garry', year: 1981, publisher: 'Garry Wills', isbn: '0316943851', user_id: 1},
  {book_num: '121465', image_count: 231, title: 'No Comebacks: Collected short stories', authors: 'Forsyth, Frederick', year: 1982, publisher: 'The Viking Press', isbn: '', user_id: 1},
  {book_num: '121480', image_count: 652, title: 'Space', authors: 'Michener, James A.', year: 1982, publisher: 'James A. Michener', isbn: '039452764X', user_id: 1},
  {book_num: '121597', image_count: 1003, title: 'The last lion, Winston Spencer Churchill', authors: 'Manchester, William', year: 1983, publisher: 'William Manchester', isbn: '0316545031', user_id: 1},
  {book_num: '121835', image_count: 597, title: 'In wars dark shadow: the Russians before the Great War', authors: 'Lincoln, W. Bruce', year: 1983, publisher: 'W. Bruce Lincoln', isbn: '0385274092', user_id: 1},
  {book_num: '121595', image_count: 585, title: 'The Kennedys: an American drama', authors: 'Collier, Peter | Horowitz, David', year: 1984, publisher: 'Peter Collier and David Horowitz', isbn: '0671447939', user_id: 1},
  {book_num: '121468', image_count: 342, title: 'The red fox', authors: 'Hyde, Anthony', year: 1985, publisher: 'Tusitala Inc.', isbn: '0394544439', user_id: 1},
  {book_num: '121471', image_count: 305, title: 'Arrogant Aussie: the Rupert Murdoch story', authors: 'Leapman, Michael', year: 1985, publisher: 'Michael Leapman', isbn: '0818403705', user_id: 1},
  {book_num: '121698', image_count: 575, title: 'The Soong Dynasty', authors: 'Seagrave, Sterling', year: 1985, publisher: 'Sterling Seagrave', isbn: '0060153083', user_id: 1},
  {book_num: '121460', image_count: 305, title: 'Alone together', authors: 'Bonner, Elena', year: 1986, publisher: 'Alfred A. Knopf, Inc', isbn: '0394558359', user_id: 1},
  {book_num: '121540', image_count: 97, title: 'Terracotta Warriors and Horses of Emperor Qin Shi Huang', authors: 'The Museum of Qin Terracotta Figures', year: 1987, publisher: 'Hong Kong Man Hai Language Publication', isbn: '9622970098', user_id: 1},
  {book_num: '121572', image_count: 503, title: 'William Shakespeare, the complete works', authors: 'Wells, Stanley | Taylor, Gary', year: 1987, publisher: 'Oxford University Press', isbn: '0198129726', user_id: 1},
  {book_num: '121573', image_count: 577, title: 'William Shakespeare, the complete works: Comedies', authors: 'Wells, Stanley | Taylor, Gary', year: 1987, publisher: 'Oxford University Press', isbn: '0198129726', user_id: 1},
  {book_num: '121574', image_count: 421, title: 'William Shakespeare, the complete works: Tragedies', authors: 'Wells, Stanley | Taylor, Gary', year: 1987, publisher: 'Oxford University Press', isbn: '0198129726', user_id: 1},
  {book_num: '121832', image_count: 496, title: 'Empire: A novel ', authors: 'Vidal, Gore', year: 1987, publisher: 'Gore Vidal', isbn: '', user_id: 1},
  {book_num: '121557', image_count: 209, title: 'Illuminated manuscripts: the book before Gutenberg', authors: 'Bologna, Giulia', year: 1988, publisher: 'Anaya Editoriale', isbn: '1555842755', user_id: 1},
  {book_num: '121559', image_count: 201, title: 'All aboard!: the golden age of American rail travel', authors: 'Yenne, Bill', year: 1989, publisher: 'Brompton Books Co.', isbn: '0880293535', user_id: 1},
  {book_num: '121810', image_count: 265, title: 'The Times atlas of the Second World War', authors: 'Keegan, John', year: 1989, publisher: 'Times Books Ltd.', isbn: '060161787', user_id: 1},
  {book_num: '121543', image_count: 293, title: 'Building Our Foundations', authors: 'The Bensalem Owl Staff', year: 1989, publisher: 'The Walsworth Publishing  Co.', isbn: '', user_id: 1},
  {book_num: '121831', image_count: 414, title: 'America in 1857: a nation on the brink', authors: 'Stampp, Kenneth M.', year: 1990, publisher: 'Oxford University Press, Inc.', isbn: '0195039025', user_id: 1},
  {book_num: '121544', image_count: 279, title: 'Piecing Together the Future', authors: 'The Bensalem Owl Staff', year: 1990, publisher: 'The Walsworth Publishing  Co.', isbn: '', user_id: 1},
  {book_num: '121839', image_count: 402, title: 'Night over water', authors: 'Follett, Ken', year: 1991, publisher: 'Ken Follett', isbn: '0688046606', user_id: 1},
  {book_num: '121840', image_count: 811, title: 'The sum of all fears', authors: 'Clancy, Tom', year: 1991, publisher: 'Jack Ryan Enterprise, Ltd.', isbn: '0399136150', user_id: 1},
  {book_num: '121542', image_count: 305, title: 'Turning into Tomorrow', authors: 'The Bensalem Owl Staff', year: 1992, publisher: 'The Walsworth Publishing  Co.', isbn: '', user_id: 1},
  {book_num: '121837', image_count: 282, title: 'Around the cragged hill: A personal and political philosophy', authors: 'Kennan, George F.', year: 1993, publisher: 'George F. Kennan', isbn: '0393034119', user_id: 1},
  {book_num: '121541', image_count: 317, title: 'Bensalems Greatest Hits', authors: 'The Bensalem Owl Staff', year: 1993, publisher: 'Walsworth Publishing Co.', isbn: '', user_id: 1},
  {book_num: '121459', image_count: 273, title: 'How the Irish saved civilization: the untold story of Irelands heroic role from the fall of Rome to the rise of medieval Europe', authors: 'Cahill, Thomas', year: 1995, publisher: 'Thomas Cahill', isbn: '0385418485', user_id: 1},
  {book_num: '121830', image_count: 437, title: 'The third twin: a novel', authors: 'Follett, Ken', year: 1996, publisher: 'Ken Follett', isbn: '0517702967', user_id: 1},
  {book_num: '121833', image_count: 762, title: 'A man in full: a novel', authors: 'Wolfe, Tom', year: 1998, publisher: 'Tom Wolfe', isbn: '0374270325', user_id: 1},
  {book_num: '121789', image_count: 213, title: 'Katys Shawl', authors: 'Wood, Walter E. ', year: 2000, publisher: 'Walter E. Wood', isbn: '074140401X', user_id: 1},
  {book_num: '121847', image_count: 296, title: 'A living constitution: the Cory Aquino presidency', authors: 'Bernas, Joaquin G.', year: 2000, publisher: 'Joaquin G. Bernas', isbn: '9712709159', user_id: 1},
  {book_num: '121827', image_count: 496, title: 'Fathers and sons: the autobiography of a family', authors: 'Waugh, Alexander', year: 2004, publisher: 'Alexander Waugh', isbn: '9780385521505', user_id: 1},
  {book_num: '121836', image_count: 361, title: 'Wolves eat dogs: a novel', authors: 'Smith, Martin Cruz', year: 2004, publisher: 'Titanic Productions', isbn: '0684872544', user_id: 1},
  {book_num: '121475', image_count: 125, title: 'Hagstrom New York City 5 borough street atlas: large type.', authors: 'Hagstrom', year: 2005, publisher: 'Hagstrom Map Company', isbn: '9781592459124', user_id: 1},
  {book_num: '121809', image_count: 673, title: 'The Sothebys Wine Encyclopedia', authors: 'Stevenson, Tom', year: 2005, publisher: 'Tom Stevenson', isbn: '0756613248', user_id: 1},
  {book_num: '121762', image_count: 509, title: 'The Aeneid', authors: 'Fagles, Robert | Knox, Bernard', year: 2006, publisher: 'Robert Fagles', isbn: '0670038032', user_id: 1},
  {book_num: '121838', image_count: 656, title: 'Cobra II: the inside story of the invasion and occupation of Iraq', authors: 'Gordon, Michael R., | Trainor, Bernard E.', year: 2006, publisher: 'Michael R. Gordon and Bernard E. Trainor', isbn: '0375422625', user_id: 1},
  {book_num: '121565', image_count: 973, title: '1001 wines you must taste before you die', authors: 'Beckett, Neil', year: 2008, publisher: 'Quintessence', isbn: '9780789316837', user_id: 1},
  {book_num: '121828', image_count: 290, title: 'An ordinary spy: a novel', authors: 'Weisberg, Joseph', year: 2008, publisher: 'Joseph Weisberg', isbn: '9781596913769', user_id: 1},
  {book_num: '121826', image_count: 280, title: 'Have a little faith: a true story', authors: 'Albom, Mitch', year: 2009, publisher: 'Mitch Albom', isbn: '9780786868728', user_id: 1},
  {book_num: '120785', image_count: 423, title: 'The Military Spirit of a Community', authors: 'John "Jack" T. Barlick, Jr.', year: 2011, publisher: '', isbn: '', user_id: 1},
  {book_num: '121461', image_count: 363, title: 'Sutton', authors: 'Moehringer, J. R. | Lenders, Nan | Jakobeit, Brigitte | Bok, Anneke', year: 2012, publisher: 'J. R. Moehringer', isbn: '9781401323141', user_id: 1},
  {book_num: '121808', image_count: 407, title: 'Stella Adler on Americas master playwrights: Eugene ONeill, Thornton Wilder, Clifford Odets, William Saroyan, Tennessee Williams, William Inge, Arthur Miller, Edward Albee', authors: 'Adler, Stella | Paris, Barry', year: 2012, publisher: 'The Estate of Stella Adler', isbn: '9780679424437', user_id: 1},
  {book_num: '120799', image_count: 407, title: 'Past and Present', authors: 'Thomas Carlyle', year: 1918, publisher: 'Charles Scribners Sons', isbn: '', user_id: 1},
  {book_num: '120796', image_count: 407, title: 'Poems and Plays', authors: 'Robert Browning', year: 1922, publisher: 'Charles Scribners Sons', isbn: '', user_id: 1},
  {book_num: '120804', image_count: 339, title: 'Selected Letters of Pliny', authors: 'J. H. Westcott', year: 1926, publisher: 'Allyn and Bacon', isbn: '', user_id: 1},
  {book_num: '120831', image_count: 561, title: 'Matthew Arnold Prose and Poetry', authors: 'Archibald L. Bouton', year: 1927, publisher: 'Charles Scribners Sons', isbn: '', user_id: 1},
  {book_num: '120781', image_count: 37, title: '"Geographia" Atlas of the Five Boroughs of New York', authors: 'Alexander Gross, F.R.G.S.', year: 1938, publisher: 'C.S. Hammond & Co.', isbn: '', user_id: 1},
  {book_num: '120800', image_count: 1207, title: 'The Oxford Book of English Verse 1250-1918', authors: 'Sir Arthur Quiller-Couch', year: 1948, publisher: 'Clarendon Press', isbn: '', user_id: 1},
  {book_num: '120805', image_count: 1193, title: 'The Oxford Book of American Verse', authors: 'F. O. Matthiessen', year: 1950, publisher: 'Oxford University Press, Inc.', isbn: '', user_id: 1},
  {book_num: '120787', image_count: 169, title: 'The Sonnets of William Shakespeare', authors: 'George McKibbin & Son', year: 1951, publisher: 'The Greystone Press', isbn: '', user_id: 1},
  {book_num: '120795', image_count: 615, title: 'Modern Poetry American and British', authors: 'Kimon Friar / John Malcolm Brinnin', year: 1951, publisher: 'Appleton-Century-Crofts, Inc.', isbn: '', user_id: 1},
  {book_num: '120802', image_count: 103, title: 'Sonnets from the Portuguese', authors: 'Elizabeth Barrett Browning', year: 1951, publisher: 'Shakespeare House', isbn: '', user_id: 1},
  {book_num: '120807', image_count: 1701, title: 'Shakespeare The Complete Works', authors: 'G. B. Harrison', year: 1952, publisher: 'Harcourt, Brace and Company', isbn: '', user_id: 1},
  {book_num: '120788', image_count: 231, title: 'The Collected Poetry of Dorothy Parker', authors: 'Dorothy Parker', year: 1959, publisher: 'Random House Inc.', isbn: '', user_id: 1}
]

# Initialize the API
service = Google::Apis::DriveV3::DriveService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize

books.each do |book|

  book = Book.new(book)
  book.save

  image_count = 0

  response = service.list_files(q: "name contains '#{book.book_num}'", page_size: 1000, fields: 'nextPageToken, files(id, name, webViewLink)')

  response.files.each do |file|
    page = Page.new({url: file.web_view_link, book_id: book.id, file_id: file.id, file_name: file.name})
    page.save
    image_count = image_count + 1
  end

  book.api_image_count = image_count
  book.save

  puts "seeded #{book.book_num} with #{image_count} images"

end
