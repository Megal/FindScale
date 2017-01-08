// FindChord.playground
// Created by Svyatoshenko "Megal" Misha on 2017-01-08

enum Note: RawRepresentable, CustomStringConvertible {

	case C
	case Csharp
	case Dflat
	case D
	case Dsharp
	case Eflat
	case E
	case F
	case Fsharp
	case Gflat
	case G
	case Gsharp
	case Aflat
	case A
	case Asharp
	case Bflat
	case B


	// MARK: RawRepresentable protocol

	typealias RawValue = Int

	public var rawValue: Note.RawValue {

		switch self {
			case .C: return 0
			case .Csharp: return 1
			case .Dflat: return 1
			case .D: return 2
			case .Dsharp: return 3
			case .Eflat: return 3
			case .E: return 4
			case .F: return 5
			case .Fsharp: return 6
			case .Gflat: return 6
			case .G: return 7
			case .Gsharp: return 8
			case .Aflat: return 8
			case .A: return 9
			case .Asharp: return 10
			case .Bflat: return 10
			case .B: return 11
		}
	}

	init?(rawValue: Note.RawValue) {

		guard rawValue >= 0 else { return nil }

		switch rawValue % 12 {
			case 0: self = .C
			case 1: self = .Csharp
			case 2: self = .D
			case 3: self = .Dsharp
			case 4: self = .E
			case 5: self = .F
			case 6: self = .Fsharp
			case 7: self = .G
			case 8: self = .Gsharp
			case 9: self = .A
			case 10: self = .Asharp
			case 11: self = .B
			default: return nil
		}
	}


	// MARK: CustomStringConvertible protocol

    public var description: String {

		switch self {
			case .C: return "C"

			case .Csharp: return "C♯"
			case .Dflat: return "D♭"

			case .D: return "D"

			case .Dsharp: return "D♯"
			case .Eflat: return "E♭"

			case .E: return "E"

			case .F: return "F"

			case .Fsharp: return "F♯"
			case .Gflat: return "G♭"

			case .G: return "G"

			case .Gsharp: return "G♯"
			case .Aflat: return "A♭"

			case .A: return "A"

			case .Asharp: return "A♯"
			case .Bflat: return "B♭"

			case .B: return "B"
		}
	}
}

func +(lhs: Note, rhs: Int) -> Note {

	guard rhs % 12 != 0 else { return lhs}

	let newNoteValue = (lhs.rawValue + rhs % 12 + 12) % 12

	return Note(rawValue: newNoteValue)!
}

let chords = [
	""	: [4, 7],
	"m" : [3, 7],
	"dim" : [3, 6],
	"aug" : [4, 8],
	"m7" : [3, 7, 10],
	"7" : [4, 7, 10],
	"M7" : [4, 7, 11],
	"m7♭5" : [3, 6, 10],
	"dim7" : [3, 6, 9],
	"mM7" : [3, 7, 11],
	"9" : [4, 10, 14],
	"M9" : [4, 11, 14],
]

let sortedChordNames = [
	"",
	"m",
	"dim",
	"aug",
	"m7",
	"7",
	"M7",
	"m7♭5",
	"dim7",
	"mM7",
	"9",
	"M9",
]

typealias ChordAsPair = (root: String, intervals: Array<Int>)

func chordNamesComparer(_ p1: ChordAsPair, _ p2: ChordAsPair) -> Bool {

	return sortedChordNames.index(of: p1.root)! < sortedChordNames.index(of: p2.root)!
}


func printChord(_ root: Note, _ chordName: String) {

	print("\(root)\(chordName)")
}

/// Find and print chords
func findChords(in scale: [Note]) {

	for root in scale {

		for (chordName, chord) in chords.sorted(by: chordNamesComparer) {

			let c = chord
				.map { interval in
					// Apply intervals
					root + interval
				}
				.filter { noteInChord in
					// Filter notes not in scale
					scale.contains(noteInChord)
				}

			// If all notes in chord `c` is
			if c.count == chord.count {

				printChord(root, chordName);
			}
		}

		print("==================")
	}
}

let scaleX = [0, 2, 4, 6, 7, 9, 10]
let scaleMaj = [0, 2, 4, 5, 7, 9, 11]
let scaleB = scaleX.map { Note.B + $0 }

findChords(in: scaleB)

