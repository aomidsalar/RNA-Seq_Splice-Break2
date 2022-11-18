#~/miniconda3/bin/python
import pysam
import pandas as pd
import sys
import os
import argparse

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--bam', help='Input BAM file')
    parser.add_argument('--out-root', help='Root directory to write output BAMs to')
    parser.add_argument('--csv', help='CSV file with two columns: barcode and cluster.')
    return parser.parse_args()



if __name__ == '__main__':
    args = parse_args()
    df = pd.read_csv(args.csv)
    assert 'barcode' in df.columns and 'cluster' in df.columns, 'Missing column identifiers'
    assert os.path.exists(args.bam), 'Cannot find input BAM'
    fh = pysam.Samfile(args.bam)
    cluster_map = dict(zip(df.barcode, df.cluster))
    os.makedirs(args.out_root)
    out_handles = {}
    for c in set(df.cluster):
        o = pysam.Samfile(os.path.join(args.out_root, 'cluster' + str(c) + '.bam'), 'wb', template=fh)
        out_handles[c] = o
    for rec in fh:
        if rec.has_tag('CB') and rec.get_tag('CB') in cluster_map:
            cluster = cluster_map[rec.get_tag('CB')]
            out_handles[cluster].write(rec)
    for h in out_handles.values():
        h.close()


